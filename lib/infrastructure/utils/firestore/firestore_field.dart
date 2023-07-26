class FireStoreField<Entity, T> {
  final String key;
  final T Function(Entity entity) data;
  final T Function(dynamic data)? _parser;

  FireStoreField(this.key, this.data, {T Function(dynamic data)? parser})
      : _parser = parser;

  dynamic toField(T data) => data;

  T parseJSON(Map<String, dynamic> firestoreData) {
    return _parser?.call(firestoreData[key]) ?? firestoreData[key];
  }
}

class FireStoreListField<Entity, T> extends FireStoreField<Entity, List<T>> {
  FireStoreListField(super.key, super.data, {super.parser});

  @override
  List<T> parseJSON(Map<String, dynamic> firestoreData) {
    return _parser?.call(firestoreData[key]) ??
        (firestoreData[key] as List).map((e) => e as T).toList();
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
