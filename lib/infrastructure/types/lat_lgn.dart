import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';

class SGLocation {
  final double lat;
  final double long;

  SGLocation({required this.lat, required this.long});
}

class LatLgnFirestoreField<Entity>
    extends FireStoreField<Entity, GeoFirePoint> {
  LatLgnFirestoreField(String key, SGLocation Function(Entity data) data)
      : super(key, (entity) {
          final latLngt = data(entity);
          return GeoFirePoint(latLngt.lat, latLngt.long);
        });

  @override
  toField(GeoFirePoint data) {
    return data.data;
  }

  @override
  GeoFirePoint parseJSON(Map<String, dynamic> firestoreData) {
    final geoPoint = firestoreData["geopoint"];
    return GeoFirePoint(geoPoint["latitude"], geoPoint["longitude"]);
  }
}
