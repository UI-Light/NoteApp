class DateUtil {
// 16:00 PM, March 7, 2022.
  static String formatDate(DateTime date) {
    final dateString = "${_month(date.month)} ${date.day}, ${date.year}";
    String period = "AM";
    if (date.hour >= 12) {
      period = "PM";
    }
    final timeString =
        "${date.hour}:${date.minute.toString().padLeft(2, "0")} $period";
    return '$timeString, $dateString';
  }

  static String _month(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
}
