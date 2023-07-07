class FireStoreField<Entity, T> {
  final String key;
  final T Function(Entity entity) data;

  FireStoreField(this.key, this.data);

  dynamic toField(T data) => data;

  T parseJSON(Map<String, dynamic> firestoreData) => firestoreData[key];
}
