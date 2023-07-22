import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';

class SGAddress {
  SGAddress({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  /// The name associated with the placemark.
  final String? name;

  /// The street associated with the placemark.
  final String? street;

  /// The abbreviated country name, according to the two letter (alpha-2) [ISO standard](https://www.iso.org/iso-3166-country-codes.html).
  final String? isoCountryCode;

  /// The name of the country associated with the placemark.
  final String? country;

  /// The postal code associated with the placemark.
  final String? postalCode;

  /// The name of the state or province associated with the placemark.
  final String? administrativeArea;

  /// Additional administrative area information for the placemark.
  final String? subAdministrativeArea;

  /// The name of the city associated with the placemark.
  final String? locality;

  /// Additional city-level information for the placemark.
  final String? subLocality;

  /// The street address associated with the placemark.
  final String? thoroughfare;

  /// Additional street address information for the placemark.
  final String? subThoroughfare;

  @override
  bool operator ==(dynamic other) =>
      other is SGAddress &&
      other.administrativeArea == administrativeArea &&
      other.country == country &&
      other.isoCountryCode == isoCountryCode &&
      other.locality == locality &&
      other.name == name &&
      other.postalCode == postalCode &&
      other.street == street &&
      other.subAdministrativeArea == subAdministrativeArea &&
      other.subLocality == subLocality &&
      other.subThoroughfare == subThoroughfare &&
      other.thoroughfare == thoroughfare;

  @override
  int get hashCode =>
      administrativeArea.hashCode ^
      country.hashCode ^
      isoCountryCode.hashCode ^
      locality.hashCode ^
      name.hashCode ^
      postalCode.hashCode ^
      street.hashCode ^
      subAdministrativeArea.hashCode ^
      subLocality.hashCode ^
      subThoroughfare.hashCode ^
      thoroughfare.hashCode;

  Map<String, dynamic> toJson() => {
        'name': name,
        'street': street,
        'isoCountryCode': isoCountryCode,
        'country': country,
        'postalCode': postalCode,
        'administrativeArea': administrativeArea,
        'subAdministrativeArea': subAdministrativeArea,
        'locality': locality,
        'subLocality': subLocality,
        'thoroughfare': thoroughfare,
        'subThoroughfare': subThoroughfare,
      };

  @override
  String toString() {
    return '''
      Name: $name, 
      Street: $street, 
      ISO Country Code: $isoCountryCode, 
      Country: $country, 
      Postal code: $postalCode, 
      Administrative area: $administrativeArea, 
      Subadministrative area: $subAdministrativeArea,
      Locality: $locality,
      Sublocality: $subLocality,
      Thoroughfare: $thoroughfare,
      Subthoroughfare: $subThoroughfare''';
  }
}

class AddressFirestoreField<Entity> extends FireStoreField<Entity, SGAddress> {
  AddressFirestoreField(super.key, super.data);

  @override
  toField(SGAddress data) {
    return {
      'name': data.name,
      'street': data.street,
      'isoCountryCode': data.isoCountryCode,
      'country': data.country,
      'postalCode': data.postalCode,
      'administrativeArea': data.administrativeArea,
      'subAdministrativeArea': data.subAdministrativeArea,
      'locality': data.locality,
      'subLocality': data.subLocality,
      'thoroughfare': data.thoroughfare,
      'subThoroughfare': data.subThoroughfare,
    };
  }

  @override
  SGAddress parseJSON(Map<String, dynamic> firestoreData) {
    final json = firestoreData[key];
    return SGAddress(
      name: json["name"],
      street: json["street"],
      isoCountryCode: json["isoCountryCode"],
      country: json["country"],
      postalCode: json["postalCode"],
      administrativeArea: json["administrativeArea"],
      subAdministrativeArea: json["subAdministrativeArea"],
      locality: json["locality"],
      subLocality: json["subLocality"],
      thoroughfare: json["thoroughfare"],
      subThoroughfare: json["subThoroughfare"],
    );
  }
}
