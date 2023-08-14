class PrescriptionInfo {
  int id = 0;
  String diseaseName = '';
  String description = '';
  String startDate = '';
  String endDate = '';
  int patientID = 0;
  int studentID = 0;
  PrescriptionInfo(
      {required this.id,
      required this.diseaseName,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.patientID,
      required this.studentID});
}
