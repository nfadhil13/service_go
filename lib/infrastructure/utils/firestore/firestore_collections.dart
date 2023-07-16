// Enum untuk melist collection dari firestore

enum FirestoreCollections {
  bengeklProfile("bengkel"),

  jenisLayanan("jenisLayanan"),

  /// User data collection berisi list data user dengan properties
  /// seperti dibawah berikut
  ///
  /// {
  ///   "email" : example@.com // Berisi email user,
  ///   "username" : "some_username" // Berisi username user,
  ///   "isBengkel" : false // Boolean yang mengindikasikan apakah user adalah customer atau bengkel
  ///
  /// }
  ///
  userData("userData");

  final String collectionName;

  const FirestoreCollections(this.collectionName);
}
