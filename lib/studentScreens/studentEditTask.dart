import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/studentScreens/studentTasks.dart';

import '../component/getAndPost.dart';
import '../constant/appliApis.dart';
import '../main.dart';
import 'showAllTasks.dart';

class StudentEditTask extends StatefulWidget {
  final int id;

  StudentEditTask({required this.id});
  @override
  State<StudentEditTask> createState() => _StudentEditTaskState();
}

class _StudentEditTaskState extends State<StudentEditTask> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController taskNameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController startDateController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  TextEditingController taskStatueController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  GetPost getPost = GetPost();

  bool isLoading = false;

  Future<void> sendEditRequest() async {
    print(widget.id);
    isLoading = true;
    setState(() {});

    var response = await getPost
        .postRequest('${url}/api/UpdateTask/${widget.id}.toString()}', {
      'task_name': taskNameController.text,
      'description': descriptionController.text,
      'starting_date': startDateController.text,
      'end_date': endDateController.text,
      'task_status': taskStatueController.text,
      'number': numberController.text
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});

    if (response['message'] == 'your task has been updated successfully') {
      Get.off(TryTask());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 300, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(TryTask());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(newOrange),
                    ),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200, top: 20),
                  child: Text('59'.tr,
                      style: TextStyle(
                          fontFamily: 'cookie',
                          color: Colors.black,
                          fontSize: 35)),
                ),
                TextFormField(
                  controller: taskNameController,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: '14'.tr,
                    fillColor: Colors.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: taskStatueController,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: '18'.tr,
                    fillColor: Colors.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: startDateController,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: '16'.tr,
                    fillColor: Colors.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: endDateController,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: '17'.tr,
                    fillColor: Colors.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: '22'.tr,
                    fillColor: Colors.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: numberController,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: '60'.tr,
                    fillColor: Colors.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await sendEditRequest();
                    },
                    child: Text('19'.tr),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(newOrange),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 90)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(ShowTasks());
                    },
                    child: Text('20'.tr),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 95)),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
