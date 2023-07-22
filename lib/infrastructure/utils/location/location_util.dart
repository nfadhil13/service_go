import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/ext/placemark_ext.dart';
import 'package:service_go/infrastructure/types/gis/placemark.dart';

abstract class LocationUtil {
  Future<SGLocation> getCurrentLocation();
}

@Injectable(as: LocationUtil)
class LocationUtilImpl implements LocationUtil {
  @override
  Future<SGLocation> getCurrentLocation() async {
    final location =
        await Geolocator.getCurrentPosition().map((value) => value.toSGLatLong);
    final placeMark =
        await placemarkFromCoordinates(location.lat, location.long);
    return SGLocation(
        location, placeMark.getAtOrNull(0)?.toSGPlaceMark() ?? SGAddress());
  }
}

extension _PostiionExt on Position {
  SGLatLong get toSGLatLong => SGLatLong(lat: latitude, long: longitude);
}
