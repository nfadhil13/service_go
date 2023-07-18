import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_mapper.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';

class CustomerProfileFirestoreEntity extends FireStoreMapper<CustomerProfile> {
  final FireStoreField<CustomerProfile, String> name =
      FireStoreField("name", (entity) => entity.nama);

  final FireStoreField<CustomerProfile, String> phoneNumber =
      FireStoreField("phoneNumber", (entity) => entity.phoneNumber);

  @override
  List<FireStoreField<CustomerProfile, dynamic>> get fields =>
      [name, phoneNumber];

  @override
  CustomerProfile toResult(Map<String, dynamic> firestoreData, String id) {
    return CustomerProfile(
        id: id,
        nama: name.parseJSON(firestoreData),
        phoneNumber: phoneNumber.parseJSON(firestoreData));
  }
}
