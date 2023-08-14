import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/studentScreens/StudentNewTask.dart';
import 'package:newstart/studentScreens/showAllTasks.dart';
import 'package:newstart/studentScreens/student_home_page.dart';

import '../constant/appColor.dart';

class TryTask extends StatefulWidget {
  @override
  State<TryTask> createState() => _TryTaskState();
}

class _TryTaskState extends State<TryTask> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 300),
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(HomePageS());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(newOrange),
                  ),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: TabBar(indicatorColor: Color(newOrange), tabs: [
                  Tab(
                    child: Text(
                      '12'.tr,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(newDarkBlue),
                          fontFamily: 'cookie'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '13'.tr,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(newDarkBlue),
                          fontFamily: 'cookie'),
                    ),
                  )
                ]),
              ),
              Expanded(
                child: TabBarView(children: [
                  Center(child: Builder(builder: (context) {
                    return StudentNewTask();
                  })),
                  Center(child: Builder(builder: (context) {
                    return ShowTasks();
                  })),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
