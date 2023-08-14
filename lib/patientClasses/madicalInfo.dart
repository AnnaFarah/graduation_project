class MedicalInfo {
  final int id;
  final String? diseaseName;
  final String? start;
  final String? end;
  final int patientID;
  final int studentID;
  final String? description;
  MedicalInfo(
      {required this.id,
      required this.diseaseName,
      required this.start,
      required this.end,
      required this.patientID,
      required this.studentID,
      required this.description});
}
