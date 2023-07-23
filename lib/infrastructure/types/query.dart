import 'package:equatable/equatable.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';

class SGDataQuery extends Equatable {
  final int? limit;
  final List<SGQueryField>? query;
  final SGLocationQuery? locationQuery;

  const SGDataQuery({this.limit, this.query, this.locationQuery});

  @override
  List<Object?> get props => [limit, query, locationQuery];
}

class SGLocationQuery extends Equatable {
  final String field;
  final double radius;
  final SGLatLong center;

  SGLocationQuery(
      {required this.field, required this.radius, required this.center});

  @override
  List<Object?> get props => [field, radius, center];
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
  SGQueryField(this.key,
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
