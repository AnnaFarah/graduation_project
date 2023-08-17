import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/student/myPatientsInfo.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';
import 'package:newstart/studentScreens/patients.dart';

import '../constant/appliApis.dart';
import '../main.dart';

class GetPatients extends StatefulWidget {
  @override
  State<GetPatients> createState() => _GetPatientsState();
}

class _GetPatientsState extends State<GetPatients> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  GetPost getPost = GetPost();

  List listOfPatients = [];

  getMyPatients() async {
    isLoading = true;
    setState(() {});

    var responseBody = await getPost.getRequest(getMyPatientsApi, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (responseBody['message'] == "These are your patients") {
      listOfPatients.addAll(responseBody['data']);
      print('List of patients : ${listOfPatients}');
      print('flutter: done getting your patients');
    } else {
      print('flutter: could not get your patients');
    }
  }

  @override
  void initState() {
    getMyPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(white),
      resizeToAvoidBottomInset: false,
      body: Form(
          key: formKey,
          child: Column(
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
              Padding(
                padding: const EdgeInsets.only(right: 200, top: 10),
                child: Text(
                  'My Patients',
                  style: TextStyle(
                      color: Color(black),
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              listOfPatients.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 210),
                      child: Center(
                        child: Text('Empty',
                            style: TextStyle(
                                fontSize: 25, color: Colors.grey.shade700)),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: listOfPatients.length,
                          itemBuilder: (context, i) {
                            MyPatientsInfo myPatientsInfo = MyPatientsInfo(
                                id: listOfPatients[i]['id'],
                                name: listOfPatients[i]['name'],
                                age: listOfPatients[i]['age'],
                                gender: listOfPatients[i]['gender'],
                                description: listOfPatients[i]['description'],
                                userID: listOfPatients[i]['user_id']);

                            return Patients(myPatientsInfo: myPatientsInfo);
                          }),
                    ),
            ],
          )),
    );
  }
}
