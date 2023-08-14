import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/student/profileInfo.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class StudentUpdateProfile extends StatefulWidget {
  final StudentProfileInfo studentProfileInfo;
  StudentUpdateProfile({required this.studentProfileInfo});

  @override
  State<StudentUpdateProfile> createState() => _StudentUpdateProfileState();
}

class _StudentUpdateProfileState extends State<StudentUpdateProfile> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  GetPost getPost = GetPost();

  TextEditingController phoneController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _updateStudentProfile() async {
    isLoading = true;
    setState(() {});

    var responseBody = await getPost.postRequest(
        '${url}/api/UpdateStudentProfile/${studentSharedPreferences.getString('id')}',
        {
          'phone': phoneController.text,
          'Region': regionController.text,
          'description': descriptionController
        },
        {
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${studentSharedPreferences.getString('token')}'
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(navyBlue),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.phone,
                                          color: Color(navyBlue),
                                          size: 30,
                                        ),
                                        hintText: "39".tr,
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w300),
                                        border: InputBorder.none),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 30),
                                    child: Divider(
                                      color: Colors.grey.shade400,
                                      thickness: 2,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: regionController,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.home,
                                          color: Color(navyBlue),
                                          size: 30,
                                        ),
                                        hintText: "49".tr,
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w300),
                                        border: InputBorder.none),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 30),
                                    child: Divider(
                                      color: Colors.grey.shade400,
                                      thickness: 2,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.description,
                                          color: Color(navyBlue),
                                          size: 30,
                                        ),
                                        hintText: "15".tr,
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w300),
                                        border: InputBorder.none),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 30),
                                    child: Divider(
                                      color: Colors.grey.shade400,
                                      thickness: 2,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await _updateStudentProfile();
                                      },
                                      child: Text('19'.tr),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(newOrange),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 120)),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Center(
                                  //   child: ElevatedButton(
                                  //     onPressed: () {
                                  //       Get.off(StudentProfile());
                                  //     },
                                  //     child: Text('Cancel'),
                                  //     style: ElevatedButton.styleFrom(
                                  //         backgroundColor: Colors.grey,
                                  //         padding: EdgeInsets.symmetric(
                                  //             vertical: 16, horizontal: 120)),
                                  //   ),
                                  // )
                                ],
                              )),
                        ]),
                  ),
                ],
              ));
  }
}
