part 'email_validator.dart';
part 'password_validator.dart';

typedef ValueValidator<Value> = String? Function(Value value);

/// Class yang digunakan untuk mempermudah proses validasi field
class ValueValidatorBuilder<Value extends dynamic> {
  final List<ValueValidator<Value>> validatorList;
  final String fieldName;

  ValueValidatorBuilder._(this.fieldName, this.validatorList);

  static ValueValidatorBuilder<T> create<T>(String fieldName) =>
      ValueValidatorBuilder._(fieldName, []);

  ValueValidatorBuilder<String?> email() =>
      EmailValidatorBuilder.create(fieldName);

  ValueValidatorBuilder<String?> password() =>
      PasswordValidator.create(fieldName);

  ValueValidatorBuilder<Value> custom(ValueValidator<Value> checker) =>
      ValueValidatorBuilder._(fieldName, [...validatorList, checker]);

  ValueValidatorBuilder<Value> notEmpty() =>
      ValueValidatorBuilder._(fieldName, [
        ...validatorList,
        (value) {
          if (value is List) {
            return value.isEmpty ? "$fieldName tidak boleh kosong" : null;
          }
          return value.toString().isEmpty
              ? "$fieldName tidak boleh kosong"
              : null;
        }
      ]);

  ValueValidatorBuilder<Value> notNull(
          {String Function(String fieldname)? error}) =>
      ValueValidatorBuilder._(fieldName, [
        ...validatorList,
        (value) {
          return value == null
              ? error?.call(fieldName) ?? "$fieldName tidak boleh kosong"
              : null;
        }
      ]);

  ValueValidatorBuilder<Value> minLengthOf(int minLenght,
          {String? errorText}) =>
      ValueValidatorBuilder._(fieldName, [
        ...validatorList,
        (value) {
          if (value is List) {
            if (value.length < minLenght) {
              return errorText ?? "$fieldName minimal adalah $minLenght";
            }
            return null;
          }
          return value.toString().length < minLenght
              ? errorText ?? "$fieldName minimal adalah $minLenght"
              : null;
        }
      ]);

  ValueValidator<Value> get build => (Value value) {
        for (final validator in validatorList) {
          final validate = validator(value);

          if (validate != null) return validate;
        }
        return null;
      };
}
