import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/homePageForPatients.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';
import 'package:newstart/studentScreens/studentLoginScreen.dart';

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
        image: DecorationImage(
            image: AssetImage("images/splash screen1.jpg"), fit: BoxFit.cover),
      ),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 500),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    studentSharedPreferences.getString('token') == null
                        ? Get.off(StudentLoginScreen())
                        : Get.off(HomePageForStudents());
                    //Get.off(StudentLoginScreen());
                  },
                  child: Text(
                    '63'.tr,
                    style: TextStyle(color: Color(NewDarkBlue), fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Color(NewLightBlue),
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 120),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    patientSharedPreferences.getString('token') == null
                        ? Get.off((patientLoginScreen()))
                        : Get.off(HomePageForPatients());
                    //Get.off(patientLoginScreen());
                  },
                  child: Text(
                    '64'.tr,
                    style: TextStyle(color: Color(NewDarkBlue), fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Color(NewLightBlue),
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 120),
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
