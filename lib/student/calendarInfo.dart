class Calendar {
  final int id;
  final String? date;
  final String? time;
  final String? type;
  final String? day;
  final int patientID;
  final int studentID;
  Calendar(
      {required this.id,
      required this.date,
      required this.time,
      required this.type,
      required this.day,
      required this.patientID,
      required this.studentID});
}
