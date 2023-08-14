import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/patientScreens/patient_home_page.dart';
import 'package:newstart/studentScreens/studentLoginScreen.dart';
import 'package:newstart/studentScreens/student_home_page.dart';

import 'main.dart';
import 'patientScreens/patientLoginScreen.dart';

class ChoseLoginType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(faintBlue), Color(faintGreen)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Column(
                  children: [
                    // Image.asset(
                    //   'icons/tooth-brush.png',
                    //   height: 65,
                    // ),
                    Text(
                      'Hollywood smile',
                      style: TextStyle(
                          fontFamily: 'cookie',
                          fontSize: 45,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      '65'.tr,
                      style: TextStyle(
                          fontFamily: 'cookie',
                          color: Colors.black,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        studentSharedPreferences.getString('token') == null
                            ? Get.off(StudentLoginScreen())
                            : Get.off(HomePageS());
                        //Get.off(StudentLoginScreen());
                      },
                      child: Text(
                        '63'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Color(navyBlue),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 120),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        patientSharedPreferences.getString('token') == null
                            ? Get.off((patientLoginScreen()))
                            : Get.off(PatientHomePage());
                        //Get.off(patientLoginScreen());
                      },
                      child: Text('64'.tr),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Color(navyBlue),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 120),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
