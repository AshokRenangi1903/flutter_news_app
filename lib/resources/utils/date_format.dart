import 'package:intl/intl.dart';

class DateFormater {
  static showDate(String date) {
    final dateTime = DateTime.parse(date);
    final formatted = DateFormat('MMMM dd,yyyy').format(dateTime).toString();
    return formatted;
  }
}
