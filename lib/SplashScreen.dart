import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/choseLoginType.dart';

import 'constant/appColor.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Get.off(ChoseLoginType());

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
                gradient: LinearGradient(
                    colors: [Color(faintGreen), Color(faintBlue)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 300),
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
                  ],
                ),
              ),
            ))
        // Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("images/Splash screen.JPG"), fit: BoxFit.cover),
        //   ),
        // ),
        );
  }
}
