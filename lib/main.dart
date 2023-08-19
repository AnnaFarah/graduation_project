import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/SplashScreen.dart';
import 'package:newstart/locale/local_controller.dart';
import 'package:newstart/locale/locale.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences patientSharedPreferences;
late SharedPreferences studentSharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // await registerOnFirebase(false);
  WidgetsFlutterBinding.ensureInitialized();
  patientSharedPreferences = await SharedPreferences.getInstance();
  studentSharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MyLocalController());
    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: MyLocale(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
