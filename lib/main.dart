import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/homePageForPatients.dart';
import 'package:newstart/locale/local_controller.dart';
import 'package:newstart/locale/locale.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences patientSharedPreferences;
late SharedPreferences studentSharedPreferences;

void main() async {
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
      home: HomePageForPatients(),
    );
  }
}
