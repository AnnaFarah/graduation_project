class PatientInfo {
  String patientToken = '';
  String patientName = '';
  String patientRole = '';
  String patientEmail = '';
  String patientAge = '';
  String patientGender = '';
  String patientDescription = '';

  PatientInfo(String token, String name, String role, String email, String age,
      String gender, String description) {
    this.patientToken = token;
    this.patientName = name;
    this.patientRole = role;
    this.patientEmail = email;
    this.patientAge = age;
    this.patientGender = gender;
    this.patientDescription = description;
  }
}
