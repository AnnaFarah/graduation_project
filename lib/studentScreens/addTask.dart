import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/studentScreens/showAllTasks.dart';

import '../constant/appliApis.dart';
import '../main.dart';

class AddTask extends StatefulWidget {
  final List posts;
  final Future<void> Function() getAllTasks;
  //final Future<void> Function() sendNewTask;
  const AddTask(
      {
      //required this.sendNewTask,
      required this.posts,
      required this.getAllTasks,
      super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool isLoading = false;
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String taskStatus = '0';
  GlobalKey<FormState> formKey = GlobalKey();
  GetPost getPost = GetPost();

  Future<void> sendNewTask() async {
    isLoading = true;
    setState(() {});
    var response = await getPost.postRequest(addTaskApi, {
      'task_name': taskNameController.text,
      'description': descriptionController.text,
      'starting_date': startDateController.text,
      'end_date': endDateController.text,
      'task_status': taskStatus
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response["message"] == "your task has been added successfully ") {
      print("success");
      Get.off(ShowTasks());
      widget.posts.clear();
      widget.getAllTasks();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Task added successfully",
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
      backgroundColor: Color(NewDarkBlue),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(white),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 300),
                      child: IconButton(
                          onPressed: () {
                            Get.off(ShowTasks());
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          )),
                    ),
                    Text(
                      'Create new task:',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 220, top: 50),
                      child: Text(
                        'Task name:',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: taskNameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Name",
                          //enabledBorder: OutlineInputBorder()
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 220, top: 30),
                      child: Text(
                        'Description:',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Description",
                          //enabledBorder: OutlineInputBorder()
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Start date:',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    controller: startDateController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: "Start date",
                                      //enabledBorder: OutlineInputBorder()
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'End date:',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 150,
                                  height: 50,
                                  child: TextFormField(
                                    controller: endDateController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: "end date",
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "  Task status:",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        DropdownButton(
                          hint: Text('Status'),
                          items: ['0', '1', '2']
                              .map((e) =>
                                  DropdownMenuItem(child: Text('$e'), value: e))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              taskStatus = val!;
                            });
                          },
                          value: taskStatus,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await sendNewTask();
                        },
                        child: isLoading == true
                            ? CircularProgressIndicator(
                                color: Color(white),
                              )
                            : Text(
                                'Add',
                                style: TextStyle(
                                    color: Color(white), fontSize: 19),
                              ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            backgroundColor: Color(newOrange),
                            fixedSize: Size(220, 50)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
