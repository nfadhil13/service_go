abstract class ToJSONMapper<T> {
  dynamic toJSON(T data);
}

abstract class FromJSONMapper<T> {
  T toModel(dynamic json);
}
