class FireStoreField<Entity, T> {
  final String key;
  final T Function(Entity entity) data;
  final T Function(Map<String, dynamic> firestoreData)? _parser;

  FireStoreField(this.key, this.data,
      {T Function(Map<String, dynamic> firestoreData)? parser})
      : _parser = parser;

  dynamic toField(T data) => data;

  T parseJSON(Map<String, dynamic> firestoreData) {
    return _parser ?? firestoreData[key];
  }
}

class FirestoreReferenceField<Entity>
    extends FireStoreField<Entity, List<String>> {
  FirestoreReferenceField(super.key, super.data);

  @override
  List<String> parseJSON(Map<String, dynamic> firestoreData) {
    return (firestoreData[key] as List).map((e) => e.toString()).toList();
  }
}
