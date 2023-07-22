import 'package:geocoding/geocoding.dart';
import 'package:service_go/infrastructure/types/gis/placemark.dart';

class PlaceMarkUtil {}

extension PlaceMarkExt on Placemark {
  SGAddress toSGPlaceMark() => SGAddress(
        name: name,
        street: street,
        isoCountryCode: isoCountryCode,
        country: country,
        postalCode: postalCode,
        administrativeArea: administrativeArea,
        subAdministrativeArea: subAdministrativeArea,
        locality: locality,
        subLocality: subLocality,
        thoroughfare: thoroughfare,
        subThoroughfare: subThoroughfare,
      );
}
