import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/types/gis/distance.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_collections.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';

class FirestoreDatasource<Entity, Mapper extends FireStoreMapper<Entity>> {
  final Mapper mapper;
  final FirestoreCollections? parentCollection;
  final FirestoreCollections collection;
  final FirebaseFirestore firestore;
  final SGLatLong Function(Entity entity)? locationMapper;

  FirestoreDatasource(
      {required this.mapper,
      this.parentCollection,
      required this.collection,
      this.locationMapper,
      required this.firestore});

  Future<int> count(
          {SGDataQuery? query,
          String Function(String collectionName)? pathBuilder}) =>
      _collectionRefNoConverter(pathBuilder: pathBuilder)
          .buildQuery(query?.query)
          .count()
          .get()
          .then((value) => value.count);

  Future<Entity> create(Entity entity,
          {String Function(String collectionName)? pathBuilder}) =>
      _collectionRefNoConverter(pathBuilder: pathBuilder)
          .add({
            ...mapper.toFirestoreObject(entity),
            FireStoreField.createdAtKey: FieldValue.serverTimestamp(),
            FireStoreField.updatedAtKey: FieldValue.serverTimestamp()
          })
          .then((value) => value.get())
          .then((value) =>
              mapper.toResult(value.data() as Map<String, dynamic>, value.id));

  Future<void> put(Entity entity, String id,
          {String Function(String collectionName)? pathBuilder}) =>
      _collectionRefNoConverter(pathBuilder: pathBuilder).doc(id).set({
        ...mapper.toFirestoreObject(entity),
        FireStoreField.updatedAtKey: FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

  Future<Entity?> fetchOne(String id,
          {String Function(String collectionName)? pathBuilder}) =>
      collectionRef(pathBuilder: pathBuilder)
          .doc(id)
          .get()
          .then((value) => value.data());

  Future<List<Entity>> fetchAll(
          {SGDataQuery? query,
          String Function(String collectionName)? pathBuilder}) =>
      collectionRef(pathBuilder: pathBuilder)
          .getWithQuery(query: query, locationMapper: locationMapper);

  Future<List<SGDistance<Entity>>> fetchAllWithDistance(
          {SGDataQuery? query,
          String Function(String collectionName)? pathBuilder}) =>
      collectionRef(pathBuilder: pathBuilder)
          .getWithQueryDistance(query: query, locationMapper: locationMapper);

  Future<List<Entity>> fetchByIds(List<String> ids,
      {String Function(String collectionName)? pathBuilder}) async {
    final ids2D = ids.mapTo2D(10);

    final futures = ids2D.map((e) => collectionRef()
        .where(FieldPath.documentId, whereIn: ids)
        .get()
        .map((value) => value.docs.map((e) => e.data())));
    final resultList = await Future.wait(futures);
    return [for (final result in resultList) ...result];
  }

  CollectionReference _collectionRefNoConverter(
      {String Function(String collectionName)? pathBuilder}) {
    return firestore.collection(pathBuilder?.call(collection.collectionName) ??
        collection.collectionName);
  }

  CollectionReference<Entity> collectionRef(
          {String Function(String collectionName)? pathBuilder}) =>
      _collectionRefNoConverter(pathBuilder: pathBuilder).withConverter(
        fromFirestore: (model, _) {
          return mapper.toResult(model.data()!, model.id);
        },
        toFirestore: (value, options) {
          return mapper.toFirestoreObject(value);
        },
      );
}

extension CollectionRef<Entity> on CollectionReference<Entity> {
  Future<List<SGDistance<Entity>>> getWithQueryDistance(
      {SGDataQuery? query,
      final SGLatLong Function(Entity entity)? locationMapper}) {
    final geoQuery = query?.locationQuery;
    if (geoQuery == null || locationMapper == null) {
      return buildQueryData(query: query).get().map((value) => value.docs
          .map((e) => SGDistance(data: e.data(), distanceInKm: -1))
          .toList());
    }
    return GeoCollectionReference(this)
        .fetchWithinWithDistance(
            center: geoQuery.center
                .let((value) => GeoFirePoint(GeoPoint(value.lat, value.long))),
            radiusInKm: geoQuery.radius,
            field: geoQuery.field,
            geopointFrom: (obj) {
              final location = locationMapper(obj);
              return GeoPoint(location.lat, location.long);
            },
            queryBuilder: (queryBuilder) =>
                queryBuilder.buildLimit(query?.limit).buildQuery(query?.query),
            strictMode: true)
        .map((value) => value
            .map((e) => SGDistance(
                // ignore: null_check_on_nullable_type_parameter
                data: e.documentSnapshot.data()!,
                distanceInKm: e.distanceFromCenterInKm))
            .toList());
  }

  Future<List<Entity>> getWithQuery(
          {SGDataQuery? query,
          final SGLatLong Function(Entity entity)? locationMapper}) =>
      getWithQueryDistance(query: query, locationMapper: locationMapper)
          .map((value) => value.map((e) => e.data).toList());

  Query<Entity> buildQueryData({SGDataQuery? query}) {
    if (query == null) return this;
    return buildLimit(query.limit)
        .buildQuery(query.query)
        .buildOrder(query.sort);
  }

  Query<Entity> buildOrder(List<SGSort> sort) {
    Query<Entity> ref = this;
    for (final sortItem in sort) {
      ref = ref.orderBy(sortItem.key,
          descending: sortItem.type == SGSortType.desc);
    }
    return ref;
  }

  Query<Entity> buildLimit(int? limit) {
    if (limit == null) return this;
    return this.limit(limit);
  }

  Query<Entity> buildQuery(List<SGQueryField>? queryFields) {
    if (queryFields == null) return this;
    Query<Entity> ref = this;
    for (final field in queryFields) {
      ref = ref.where(field.key,
          isEqualTo: field.isEqual,
          isNotEqualTo: field.isNotEqual,
          isLessThan: field.isLessThan,
          isLessThanOrEqualTo: field.isLessThanOrEqualTo,
          isGreaterThan: field.isGreaterThan,
          isGreaterThanOrEqualTo: field.isGreaterThanOrEqualTo,
          isNull: field.isNull,
          whereIn: field.whereIn,
          whereNotIn: field.whereNotIn,
          arrayContains: field.arrayContains,
          arrayContainsAny: field.arrayContainsAny);
    }
    return ref;
  }
}

extension QueryExt<Entity> on Query<Entity> {
  Query<Entity> buildQueryData({SGDataQuery? query}) {
    if (query == null) return this;
    return buildLimit(query.limit);
  }

  Query<Entity> buildOrder(List<SGSort> sort) {
    Query<Entity> ref = this;
    for (final sortItem in sort) {
      ref = ref.orderBy(sortItem.key,
          descending: sortItem.type == SGSortType.desc);
    }
    return ref;
  }

  Query<Entity> buildLimit(int? limit) {
    if (limit == null) return this;
    return this.limit(limit);
  }

  Query<Entity> buildQuery(List<SGQueryField>? queryFields) {
    if (queryFields == null) return this;
    Query<Entity> ref = this;
    for (final field in queryFields) {
      ref = ref.where(field.key,
          isEqualTo: field.isEqual,
          isNotEqualTo: field.isNotEqual,
          isLessThan: field.isLessThan,
          isLessThanOrEqualTo: field.isLessThanOrEqualTo,
          isGreaterThan: field.isGreaterThan,
          isGreaterThanOrEqualTo: field.isGreaterThanOrEqualTo,
          isNull: field.isNull,
          whereIn: field.whereIn,
          whereNotIn: field.whereNotIn,
          arrayContains: field.arrayContains,
          arrayContainsAny: field.arrayContainsAny);
    }
    return ref;
  }
}
