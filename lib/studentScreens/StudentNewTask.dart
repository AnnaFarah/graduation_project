import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';

import '../constant/appliApis.dart';
import '../main.dart';

class StudentNewTask extends StatefulWidget {
  @override
  State<StudentNewTask> createState() => _StudentNewTaskState();
}

class _StudentNewTaskState extends State<StudentNewTask> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController taskNameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController startDateController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  TextEditingController taskStatueController = TextEditingController();

  GetPost getPost = GetPost();

  bool isLoading = false;

  sendNewTask() async {
    isLoading = true;
    setState(() {});
    var response = await getPost.postRequest(addTaskApi, {
      'task_name': taskNameController.text,
      'description': descriptionController.text,
      'starting_date': startDateController.text,
      'end_date': endDateController.text,
      'task_status': taskStatueController.text
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response["message"] == "your task has been added successfully ") {
      print("success");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Added successfully",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      print('error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error! something went wrong.",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    obscureText: false,
                    controller: taskNameController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.task_alt_outlined,
                          color: Color(navyBlue),
                          size: 30,
                        ),
                        hintText: "14".tr,
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: false,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.description_outlined,
                          color: Color(navyBlue),
                          size: 30,
                        ),
                        hintText: "15".tr,
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: false,
                    controller: startDateController,
                    // validator: (val) {
                    //   return validator(val!, 3, 40);
                    // },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.date_range_outlined,
                          color: Color(navyBlue),
                          size: 30,
                        ),
                        hintText: "16".tr,
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: false,
                    controller: endDateController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.date_range_outlined,
                          color: Color(navyBlue),
                          size: 30,
                        ),
                        hintText: "17".tr,
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: false,
                    controller: taskStatueController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.task_alt_outlined,
                          color: Color(navyBlue),
                          size: 30,
                        ),
                        hintText: "18".tr,
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 50, right: 50),
                    child: ElevatedButton(
                      onPressed: () async {
                        await sendNewTask();
                      },
                      child: Text('19'.tr),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(newOrange),
                          fixedSize: Size(300, 50)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
