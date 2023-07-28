import 'package:equatable/equatable.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';

class SGDataQuery extends Equatable {
  final int? limit;
  final List<SGQueryField>? query;
  final SGLocationQuery? locationQuery;

  const SGDataQuery({this.limit, this.query, this.locationQuery});

  SGDataQuery copyWith({
    int? limit,
    List<SGQueryField>? query,
    SGLocationQuery? locationQuery,
  }) {
    return SGDataQuery(
      limit: limit ?? this.limit,
      query: query ?? this.query,
      locationQuery: locationQuery ?? this.locationQuery,
    );
  }

  @override
  List<Object?> get props => [limit, query, locationQuery];
}

class SGLocationQuery extends Equatable {
  final String field;
  final double radius;
  final SGLatLong center;

  const SGLocationQuery(
      {required this.field, required this.radius, required this.center});

  @override
  List<Object?> get props => [field, radius, center];

  SGLocationQuery copyWith({
    String? field,
    double? radius,
    SGLatLong? center,
  }) {
    return SGLocationQuery(
      field: field ?? this.field,
      radius: radius ?? this.radius,
      center: center ?? this.center,
    );
  }
}

class SGQueryField extends Equatable {
  final String key;
  final Object? isEqual;
  final Object? isNotEqual;
  final Object? isLessThan;
  final Object? isLessThanOrEqualTo;
  final Object? isGreaterThan;
  final Object? isGreaterThanOrEqualTo;
  final Object? arrayContains;
  final Iterable<Object?>? arrayContainsAny;
  final Iterable<Object?>? whereIn;
  final Iterable<Object?>? whereNotIn;
  final bool? isNull;
  const SGQueryField(this.key,
      {this.isEqual,
      this.isNotEqual,
      this.isLessThan,
      this.isNull,
      this.isLessThanOrEqualTo,
      this.isGreaterThan,
      this.arrayContains,
      this.arrayContainsAny,
      this.whereIn,
      this.whereNotIn,
      this.isGreaterThanOrEqualTo});

  SGQueryField copyWith({
    String? key,
    Object? isEqual,
    Object? isNotEqual,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    Iterable<Object?>? arrayContainsAny,
    Iterable<Object?>? whereIn,
    Iterable<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return SGQueryField(
      key ?? this.key,
      isEqual: isEqual ?? this.isEqual,
      isNotEqual: isNotEqual ?? this.isNotEqual,
      isLessThan: isLessThan ?? this.isLessThan,
      isLessThanOrEqualTo: isLessThanOrEqualTo ?? this.isLessThanOrEqualTo,
      isGreaterThan: isGreaterThan ?? this.isGreaterThan,
      isGreaterThanOrEqualTo:
          isGreaterThanOrEqualTo ?? this.isGreaterThanOrEqualTo,
      arrayContains: arrayContains ?? this.arrayContains,
      arrayContainsAny: arrayContainsAny ?? this.arrayContainsAny,
      whereIn: whereIn ?? this.whereIn,
      whereNotIn: whereNotIn ?? this.whereNotIn,
      isNull: isNull ?? this.isNull,
    );
  }

  @override
  List<Object?> get props => [
        key,
        isEqual,
        isNotEqual,
        isLessThan,
        isLessThanOrEqualTo,
        isGreaterThan,
        isGreaterThanOrEqualTo,
        arrayContains,
        arrayContainsAny,
        whereIn,
        whereNotIn,
        isNull
      ];
}
