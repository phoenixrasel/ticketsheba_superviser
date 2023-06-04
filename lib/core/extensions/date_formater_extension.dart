import 'package:intl/intl.dart';

extension DateFormater on DateTime {
  String dateFormat(String format) => DateFormat(format).format(this);
}
