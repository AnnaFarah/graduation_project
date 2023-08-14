import 'package:flutter/material.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/component/prescription.dart';

import '../constant/appliApis.dart';
import '../main.dart';

class ShowAllPrescription extends StatefulWidget {
  @override
  State<ShowAllPrescription> createState() => _ShowAllPrescriptionState();
}

class _ShowAllPrescriptionState extends State<ShowAllPrescription> {
  GetPost getPost = GetPost();

  bool isLoading = false;

  late PrescriptionInfo prescriptionInfo;

  showSinglePrescription() async {
    isLoading = true;
    setState(() {});

    var responseBody =
        await getPost.getRequest('${url}/api/ShowSinglePrescription/1', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});

    if (responseBody['message'] ==
        "your prescription has been fetched successfully") {
      prescriptionInfo = PrescriptionInfo(
          id: responseBody['data']['id'],
          diseaseName: responseBody['data']['disease_name'],
          description: responseBody['data']['description'],
          startDate: responseBody['data']['starting_date'],
          endDate: responseBody['data']['end_date'],
          patientID: responseBody['data']['patient_id'],
          studentID: responseBody['data']['student_id']);
      print('flutter: success showing prescription');
    } else {
      print('flutter: error showing prescription');
    }
  }

  @override
  void initState() {
    showSinglePrescription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Text('id: ${prescriptionInfo.id}')]),
    );
  }
}
