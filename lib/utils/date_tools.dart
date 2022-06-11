import 'package:intl/intl.dart';

class DateTools {
  static convertUTCToLocalString(String utcDate) {
    var dateValue = DateFormat("yyyy-MM-dd HH:mm:ss").parseUTC(utcDate).toLocal();
    return DateFormat("dd/MM/yyyy").format(dateValue);
  }

  static convertUTCToLocalHumanString(String utcDate) {
    var dateValue = DateFormat("yyyy-MM-dd HH:mm:ss").parseUTC(utcDate).toLocal();
    return DateFormat("dd MMMM yyyy", 'FR_FR').format(dateValue);
  }
}