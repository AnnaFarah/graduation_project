import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/homePageForPatients.dart';
import 'package:newstart/patientClasses/patientAppointmentFromData.dart';
import 'package:newstart/patientScreens/appointmentDetails.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class Appointments extends StatefulWidget {
  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List appointments = [];
  GetPost getPost = GetPost();
  bool isLoading = false;

  getAppointments() async {
    isLoading = true;
    setState(() {});

    var response = await getPost.getRequest('${url}/api/myAppointment', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${patientSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response['message'] == 'These are your appointments') {
      appointments.addAll(response['data']);
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(white),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 330, top: 30),
            child: IconButton(
              onPressed: () {
                Get.off(HomePageForPatients());
              },
              icon: Icon(Icons.arrow_back),
              color: Color(black),
              iconSize: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 200, top: 10),
            child: Text(
              'My requests',
              style: TextStyle(
                  color: Color(black),
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          appointments.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 210),
                  child: Center(
                      child: Text(
                    'No requests',
                    style: TextStyle(fontSize: 25, color: Colors.grey.shade700),
                  )),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, i) {
                        PatientAppointmentFromData patientAppointmentFromData =
                            PatientAppointmentFromData(
                                day: appointments[i]['day'],
                                time: appointments[i]['time'],
                                date: appointments[i]['date'],
                                type: appointments[i]['type'],
                                id: appointments[i]['id']);
                        return AppointmentDetails(
                          patientAppointmentFromData:
                              patientAppointmentFromData,
                        );
                      }))
        ],
      ),
    );
  }
}
