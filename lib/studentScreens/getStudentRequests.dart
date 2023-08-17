import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/student/requestInfo.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';
import 'package:newstart/studentScreens/requests.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class GetStudentRequest extends StatefulWidget {
  @override
  State<GetStudentRequest> createState() => _GetStudentRequestState();
}

class _GetStudentRequestState extends State<GetStudentRequest> {
  List appointments = [];
  GetPost getPost = GetPost();
  bool isLoading = false;

  getAppointments() async {
    isLoading = true;
    setState(() {});

    var response = await getPost.getRequest('${url}/api/ViewMyRequests', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response['message'] == 'these are your requests') {
      print('got your requests');
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
                Get.off(HomePageForStudents());
              },
              icon: Icon(Icons.arrow_back),
              color: Color(black),
              iconSize: 35,
            ),
          ),
          Center(
            child: Text(
              'My requests',
              style: TextStyle(
                  color: Color(newOrange),
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
                        RequestInfo requestInfo = RequestInfo(
                            id: appointments[i]['id'],
                            priority: appointments[i]['priority'],
                            specialization: appointments[i]['specialization'],
                            year: appointments[i]['year']);
                        return StudentRequests(requestInfo: requestInfo);
                      }))
        ],
      ),
    );
  }
}
