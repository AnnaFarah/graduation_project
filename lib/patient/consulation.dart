class ConsulateInfo {
  final int id;
  final int patientID;
  final int? isDone;
  final String? description;
  final String? phoneNumber;
  final String? type;

  ConsulateInfo(
      {required this.id,
      required this.patientID,
      required this.isDone,
      required this.description,
      required this.phoneNumber,
      required this.type});
}
