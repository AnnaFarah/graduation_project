import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/Controller/changeDate.dart';
import 'package:newstart/locale/local_controller.dart';
import 'package:newstart/patientScreens/appointments.dart';
import 'package:newstart/patientScreens/makeAnAppointment.dart';
import 'package:newstart/patientScreens/medicalProfile.dart';
import 'package:newstart/patientScreens/patientProfileScreen.dart';
import 'package:newstart/student/notificationsstudent.dart';

import 'chat/controllers/chat_with_admin_controller.dart';
import 'chat/views/chat_view.dart';
import 'choseLoginType.dart';
import 'component/getAndPost.dart';
import 'constant/appColor.dart';
import 'constant/appliApis.dart';
import 'main.dart';

class HomePageForPatients extends StatefulWidget {
  @override
  State<HomePageForPatients> createState() => _HomePageForPatientsState();
}

class _HomePageForPatientsState extends State<HomePageForPatients> {
  GetPost getPost = GetPost();
  bool isLoading = false;
  List appointmentList = [];
  int day = DateTime.now().day;
  int currentIndex = 0;
  ChangeDate changeDate =
      new ChangeDate(DateTime.now().month, DateTime.now().weekday);

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
  Widget build(BuildContext context) {
    MyLocalController controllerLang = Get.find();
    return Scaffold(
      backgroundColor: Color(white),
      drawer: Drawer(
        backgroundColor: Color(NewDarkBlue),
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(Icons.logout_outlined, color: Colors.white, size: 30),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {
                      patientSharedPreferences.clear();
                      Get.off(ChoseLoginType());
                    },
                    child: Text('8'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 17)))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              '9'.tr,
              style: TextStyle(color: Color(white), fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color(white),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                ),
                onPressed: () {
                  controllerLang.changeLanguage('ar');
                },
                child: Text(
                  '10'.tr,
                  style: TextStyle(color: Color(NewDarkBlue)),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color(white),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                ),
                onPressed: () {
                  controllerLang.changeLanguage('en');
                },
                child: Text(
                  '11'.tr,
                  style: TextStyle(color: Color(NewDarkBlue)),
                )),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu_rounded),
                    iconSize: 30,
                  );
                }),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(NotificationStudentView());
                      },
                      icon: Icon(Icons.notifications_none_sharp),
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () async {
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
                              'name':
                                  patientSharedPreferences.getString('name')!,
                              'isDoctor': false,
                            },
                          );
                        }
                        return;
                      },
                      icon: Icon(Icons.chat_bubble_outline_outlined),
                      iconSize: 30,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hi, ',
                        style: TextStyle(color: Color(black), fontSize: 25),
                      ),
                      Text('${patientSharedPreferences.getString('name')}',
                          style: TextStyle(color: Color(black), fontSize: 25))
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("Have a nice day",
                      style: TextStyle(
                          color: Color(black),
                          fontSize: 25,
                          fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: Text(
                      '${changeDate.getWeekName()} , ${changeDate.getMonthName()} , ${day}',
                      style:
                          TextStyle(color: Colors.grey.shade900, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 400,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Color(0xffDDE9F8),
                        //border: Border.all(),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Looking for the right doctor?',
                            style: TextStyle(
                                color: Color(black),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'We will find your best match',
                            style: TextStyle(color: Color(black), fontSize: 18),
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(MAkeAnAppointment());
                              },
                              child: Center(
                                child: Text(
                                  'Send request',
                                  style: TextStyle(
                                      color: Color(newOrange), fontSize: 16),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  //side: BorderSide(color: Colors.black, width: 1),
                                  foregroundColor: Colors.black,
                                  backgroundColor: Color(white),
                                  elevation: 2,
                                  //padding: EdgeInsets.all(10),
                                  fixedSize: Size(200, 10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Already made a request ?',
                        style: TextStyle(
                            color: Color(black),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(Appointments());
                          },
                          child: Text(
                            'Check it',
                            style: TextStyle(
                                color: Color(newOrange), fontSize: 18),
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Also, check your:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(MedicalProfile());
                    },
                    child: Text(
                      'Medical profile',
                      style: TextStyle(color: Color(white), fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        //side: BorderSide(color: Colors.black, width: 1),
                        foregroundColor: Colors.black,
                        backgroundColor: Color(0xff153762),
                        elevation: 5,
                        padding: EdgeInsets.all(10),
                        fixedSize: Size(400, 80)),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        ],
      ),
    );
  }
}
