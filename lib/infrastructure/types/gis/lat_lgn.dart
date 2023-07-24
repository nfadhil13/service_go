import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_go/infrastructure/types/gis/placemark.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';

class SGLatLong extends Equatable {
  final double lat;
  final double long;

  const SGLatLong({required this.lat, required this.long});

  @override
  List<Object?> get props => [lat, long];

  CameraPosition get cameraPostion =>
      CameraPosition(target: LatLng(lat, long), zoom: 19.151926040649414);
}

class LatLgnFirestoreField<Entity>
    extends FireStoreField<Entity, GeoFirePoint> {
  LatLgnFirestoreField(String key, SGLatLong Function(Entity data) data)
      : super(key, (entity) {
          final latLngt = data(entity);
          return GeoFirePoint(GeoPoint(latLngt.lat, latLngt.long));
        });

  @override
  toField(GeoFirePoint data) {
    return data.data;
  }

  @override
  GeoFirePoint parseJSON(Map<String, dynamic> firestoreData) {
    final geoPoint = firestoreData[key]["geopoint"] as GeoPoint;
    return GeoFirePoint(geoPoint);
  }
}

class SGLocation extends Equatable {
  final SGLatLong latLgn;
  final SGAddress placemark;

  const SGLocation(this.latLgn, this.placemark);

  String get shortAddress => placemark.shortAddress;

  String get addressString => placemark.addressString;

  @override
  List<Object?> get props => [latLgn, placemark];
}
