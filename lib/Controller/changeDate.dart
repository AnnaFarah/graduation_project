class ChangeDate {
  late String month;
  late String week;
  ChangeDate(int m, int w) {
    if (m == 1) {
      this.month = 'January';
    } else if (m == 2) {
      this.month = 'February';
    } else if (m == 3) {
      this.month = 'March';
    } else if (m == 4) {
      this.month = 'April';
    } else if (m == 5) {
      this.month = 'May';
    } else if (m == 6) {
      this.month = 'June';
    } else if (m == 7) {
      this.month = 'July';
    } else if (m == 8) {
      this.month = 'August';
    } else if (m == 9) {
      this.month = 'September';
    } else if (m == 10) {
      this.month = 'October';
    } else if (m == 11) {
      this.month = 'November';
    } else if (m == 12) {
      this.month = 'December';
    }

    if (w == 1) {
      week = 'Monday';
    } else if (w == 2) {
      week = 'Tuesday';
    } else if (w == 3) {
      week = 'Wednesday';
    } else if (w == 4) {
      week = 'Thursday';
    } else if (w == 5) {
      week = 'Friday';
    } else if (w == 6) {
      week = 'Saturday';
    } else if (w == 7) {
      week = 'Sunday';
    }
  }

  String getMonthName() {
    return month;
  }

  String getWeekName() {
    return week;
  }
}
