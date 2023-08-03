import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String hourStringForm({String pattern = "HH:mm", String locale = 'id'}) =>
      DateFormat(pattern).format(this);

  String dateStringForm({String pattern = 'dd/MM/yyyy', String locale = 'id'}) {
    final dateFormater = DateFormat(pattern);
    return dateFormater.format(this);
  }
}
