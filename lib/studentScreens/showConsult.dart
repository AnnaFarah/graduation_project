import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/studentScreens/student_home_page.dart';

import '../constant/appColor.dart';

class ShowConsult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.off(HomePageS());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(newOrange),
          ),
          child: Icon(Icons.arrow_back),
        ),
      ],
    );
  }
}
