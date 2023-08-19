import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';

import '../constant/appColor.dart';

class ShowConsult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.off(HomePageForStudents());
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
