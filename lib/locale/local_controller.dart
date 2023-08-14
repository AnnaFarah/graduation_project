import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLocalController extends GetxController {
  void changeLanguage(String codeLanguage) {
    Locale locale = Locale(codeLanguage);
    Get.updateLocale(locale);
  }
}
