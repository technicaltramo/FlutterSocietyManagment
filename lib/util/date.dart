
class DateUtil {

  static dayMonthYearFromDate(DateTime dateTime) {
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;
    return "$day/$month/$year";
  }

  static dayMonthYearFromDateString(String strDate) {
    if (strDate == null || strDate.isEmpty) return "";
    DateTime dateTime = DateTime.parse(strDate);
    return dayMonthYearFromDate(dateTime);
  }

  static monthFromNumber(int i) {
    switch (i) {
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
    }
  }
}
