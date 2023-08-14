class PatientRequest {
  String requestPhoneNumber = '';
  String requestType = '';
  String requestDescription = '';
  String requestTitle = '';
  String requestUpdated = '';
  String requestCreated = '';
  int requestID = 0;
  int requestPatientID = 0;

  PatientRequest(String phoneNumber, String type, String description,
      String title, String updated, String created, int ID, int patientID) {
    this.requestPhoneNumber = phoneNumber;
    this.requestType = type;
    this.requestDescription = description;
    this.requestTitle = title;
    this.requestUpdated = updated;
    this.requestCreated = created;
    this.requestID = ID;
    this.requestPatientID = patientID;
  }
}
