import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/homePageForPatients.dart';
import 'package:newstart/patientScreens/patientLoginScreen.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';
import 'package:newstart/studentScreens/studentLoginScreen.dart';

import 'constant/appColor.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      setState(() {
        isLoading = false;
      });
    });
    //Get.off(ChoseLoginType());

    // Navigator.pushReplacement(
    //    context, MaterialPageRoute(builder: (context) => ChoseLoginType()));
  }

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
            child: isLoading == true
                ? SizedBox()
                : Column(
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
                          style: TextStyle(
                              color: Color(NewDarkBlue), fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Color(NewLightBlue),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 120),
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
                          style: TextStyle(
                              color: Color(NewDarkBlue), fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Color(NewLightBlue),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 120),
                        ),
                      ),
                    ],
                  )),
      ),
    ));
  }
}
