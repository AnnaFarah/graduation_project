import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appliApis.dart';
import 'package:newstart/patientScreens/makeAnAppointment.dart';
import 'package:newstart/patientScreens/medicalProfile.dart';
import 'package:newstart/patientScreens/patientProfileScreen.dart';

import '../chat/controllers/chat_with_admin_controller.dart';
import '../chat/views/chat_view.dart';
import '../choseLoginType.dart';
import '../constant/appColor.dart';
import '../locale/local_controller.dart';
import '../main.dart';
import '../student/notificationsstudent.dart';
import 'package:http/http.dart' as http;

class PatientHomePage extends StatefulWidget {
  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  List appointmentList = [];

  GetPost getPost = GetPost();

  int currentIndex = 0;

  bool isLoading = false;

  appointment() async {
    isLoading = true;
    setState(() {});

    var response = await getPost.getRequest(patientAppointmentApi, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${patientSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});
    if (response['message'] == "These are your appointments") {
      appointmentList.addAll(response['data']);
      print('appointment: ${appointmentList}');
    }
  }

  @override
  void initState() {
    appointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyLocalController controllerLang = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(paletsBackground),
      drawer: Drawer(
        backgroundColor: Color(newDarkBlue),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(children: [
            Row(
              children: [
                Icon(Icons.logout_outlined, color: Colors.white, size: 30),
                TextButton(
                    onPressed: () {
                      patientSharedPreferences.clear();
                      Get.off(ChoseLoginType());
                    },
                    child: Text('8'.tr,
                        style: TextStyle(
                          color: Colors.white,
                        )))
              ],
            ),
            Text('9'.tr),
            ElevatedButton(
                onPressed: () {
                  controllerLang.changeLanguage('ar');
                },
                child: Text('10'.tr)),
            ElevatedButton(
                onPressed: () {
                  controllerLang.changeLanguage('en');
                },
                child: Text('11'.tr)),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu_outlined),
                  iconSize: 30,
                );
              }),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(NotificationStudentView());
                    },
                    icon: Icon(Icons.notifications),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () async {
                      log(patientSharedPreferences
                          .getString('token')
                          .toString());
                      var response = await http.get(
                        Uri.parse(
                          '${url}/api/FindOutMyStudentID',
                        ),
                        headers: {
                          'Accept': 'application/json',
                          'Authorization':
                              'Bearer ${patientSharedPreferences.getString('token')}'
                        },
                      );
                      if (response.statusCode != 200) {
                        showDialog(
                          context: context,
                          builder: (x) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                title: Text("عذراً"),
                                content: Text("لايوجد أطباء لهذا المريض"),
                              ),
                            );
                          },
                        );
                      } else {
                        Get.lazyPut(() => ChatController());
                        Get.to(
                          ChatView(
                            patient_id: int.parse(
                                patientSharedPreferences.getString('id')!),
                            doctor_id: jsonDecode((response.body))['data']
                                ['student_id'],
                            name: patientSharedPreferences.getString('name')!,
                            isDocotor: false,
                          ),
                          arguments: {
                            'patient_id': int.parse(
                                patientSharedPreferences.getString('id')!),
                            'doctor_id': jsonDecode((response.body))['data']
                                ['student_id'],
                            'name': patientSharedPreferences.getString('name')!,
                            'isDoctor': false,
                          },
                        );
                      }
                      inspect(response);
                      return;
                    },
                    icon: Icon(Icons.message),
                    iconSize: 30,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  '52'.tr,
                  style: TextStyle(fontSize: 30),
                ),
                Text(', ${patientSharedPreferences.getString('name')}',
                    style: TextStyle(fontSize: 30))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
                child: Image.asset(
              'images/doctors.JPG',
              height: 200,
              //width: 800,
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Looking for doctor?',
                style: TextStyle(fontSize: 20, color: Color(black)),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(MAkeAnAppointment());
                },
                child: Text(
                  '5'.tr,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(newOrange),
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
              ),
            ],
          ),
          SizedBox(height: 30),
          appointmentList.isEmpty
              ? ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'No appointment',
                    style: TextStyle(),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      side: BorderSide(color: Colors.black, width: 1),
                      foregroundColor: Colors.black,
                      backgroundColor: Color(paletsBackground),
                      elevation: 0,
                      padding: EdgeInsets.all(10),
                      fixedSize: Size(310, 150)),
                )
              : ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Empty',
                    style: TextStyle(),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      side: BorderSide(color: Colors.black, width: 1),
                      foregroundColor: Colors.black,
                      backgroundColor: Color(paletsBackground),
                      elevation: 0,
                      padding: EdgeInsets.all(10),
                      fixedSize: Size(310, 150)),
                ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.off(MedicalProfile());
            },
            child: Text(
              'View medical profile',
              style: TextStyle(),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                side: BorderSide(color: Color(blue), width: 1),
                foregroundColor: Color(black),
                backgroundColor: Color(blue),
                elevation: 2,
                padding: EdgeInsets.all(10),
                fixedSize: Size(310, 70)),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedLabelStyle: TextStyle(color: Color(darkBlue)),
        onTap: (value) {
          setState(() {
            currentIndex = value;
            if (currentIndex == 1) {
              Get.off(PatientProfileScreen());
            }
            // else if (currentIndex == 3) {
            //   patientSharedPreferences.clear();
            //   Get.off(ChoseLoginType());
            // }
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Color(navyBlue),
              ),
              label: ''),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              color: Color(navyBlue),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: Color(navyBlue),
            ),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.logout_outlined,
          //     color: Color(navyBlue),
          //   ),
          //   label: '',
          // ),
        ],
      ),
    );
  }
}
