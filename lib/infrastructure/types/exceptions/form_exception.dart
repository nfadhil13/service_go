import 'package:service_go/infrastructure/types/exceptions/base_exception.dart';

class FormException extends BaseException {
  final Map<String, String> errors;
  FormException(super.message, {this.errors = const {}});

  String? get getFirstError {
    if (errors.isEmpty) return null;
    final firstEntry = errors.entries.first.value;
    if (firstEntry.isEmpty) return null;
    return firstEntry;
  }
}
