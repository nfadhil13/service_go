class FireStoreField<Entity, T> {
  final String key;
  final T Function(Entity entity) data;

  FireStoreField(this.key, this.data);

  T parse(Map<String, dynamic> firestoreData) => firestoreData[key];
}
