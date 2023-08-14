import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/task.dart';
import 'package:newstart/component/textField.dart';
import 'package:newstart/homePageFroStudents.dart';
import 'package:newstart/studentScreens/tasks.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class ShowTasks extends StatefulWidget {
  @override
  State<ShowTasks> createState() => _ShowTasksState();
}

class _ShowTasksState extends State<ShowTasks> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String taskStatus = '0';

  List posts = [];

  bool isLoading = false;

  GetPost getPost = GetPost();

  getAllTasks() async {
    isLoading = true;
    setState(() {});
    var responseBody = await getPost.getRequest(showAllTasksApi, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});
    if (responseBody['message'] ==
        "All tasks has been  fetched successfully ") {
      posts.addAll(responseBody['data']);
      print(posts);
      print("success in getting tasks");
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    getAllTasks();
    super.initState();
  }

  sendNewTask() async {
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
      Navigator.of(context).pop();
      posts.clear();
      getAllTasks();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "Task added successfully",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ));
    } else {
      print('error');
    }
  }

  Future<void> deleteTask(int id) async {
    isLoading = true;
    setState(() {});
    var response = await getPost.deleteRequest('${url}/api/DeleteTask/${id}', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});
    if (response["message"] == "your task has been deleted successfully ") {
      print('done deleting your task in flutter too');
      posts.clear();
      getAllTasks();
      //getAllTasks();
      //Get.off(ShowTasks());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "Task had been deleted successfully",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ));
    }
  }

  Future<void> finishTask(int id, int status) async {
    isLoading = true;
    setState(() {});
    var response = await getPost.postRequest('${url}/api/FinishTask/${id}', {
      'task_status': status.toString()
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response['message'] == "your task has been finished successfully") {
      print('finished task');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "Done",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ));
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(white),
      resizeToAvoidBottomInset: false,
      body:
          // posts.isEmpty
          //     ? CircularProgressIndicator()
          //     :
          Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 350, top: 17),
                    child: IconButton(
                      onPressed: () {
                        Get.off(HomePageForStudents());
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Color(black),
                      iconSize: 35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 220, top: 10),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                          color: Color(black),
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, i) {
                          Task task = Task(
                              posts[i]['id'],
                              posts[i]['task_name'],
                              posts[i]['description'],
                              posts[i]['starting_date'],
                              posts[i]['end_date'],
                              posts[i]['task_status']);

                          //print(controller.posts.length);

                          return posts.isEmpty
                              ? CircularProgressIndicator()
                              : TaskStudent(
                                  task: task,
                                  deleteTask: deleteTask,
                                  finishTask: finishTask);
                        }),
                  ),
                ],
              )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                      'Add Task',
                      style:
                          TextStyle(color: Color(newdarkGreen), fontSize: 20),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await sendNewTask();
                          },
                          child: isLoading == true
                              ? CircularProgressIndicator(
                                  color: Color(newblack),
                                )
                              : Text(
                                  'Add',
                                  style: TextStyle(
                                      color: Color(lightGreen), fontSize: 15),
                                )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )),
                    ],
                    content: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFieldComponent(
                            hint: 'Task name',
                            myController: taskNameController),
                        SizedBox(height: 20),
                        TextFieldComponent(
                            hint: 'Description',
                            myController: descriptionController),
                        SizedBox(height: 20),
                        TextFieldComponent(
                            hint: 'Start date',
                            myController: startDateController),
                        SizedBox(height: 20),
                        TextFieldComponent(
                            hint: 'End date', myController: endDateController),
                        SizedBox(height: 20),
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
                  ));
        },
        // child: Row(
        //   children: [
        //     Icon(
        //       Icons.add,
        //       color: Color(white),
        //     ),
        //     Text('Add new task', style: TextStyle(color: Color(white)))
        //   ],
        // ),
        backgroundColor: Color(0xff3E4685),
        label: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: Color(white), borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.add,
                color: Color(0xff3E4685),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text('Add new task', style: TextStyle(color: Color(white)))
          ],
        ),
        //foregroundColor: Color(white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// class EditTaskItem extends StatefulWidget {
//   final Task task;
//   final Future<void> Function(int) deleteTask;
//   final Future<void> Function(int, int) finishTask;
//   const EditTaskItem(
//       {required this.task,
//       required this.deleteTask,
//       required this.finishTask,
//       super.key});

//   @override
//   State<EditTaskItem> createState() => _EditTaskItemState();
// }

// class _EditTaskItemState extends State<EditTaskItem> {
//   bool checkboxValue = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Checkbox(
//                   //splashRadius: 100,

//                   checkColor: Color(newOrange),
//                   activeColor: Colors.white,
//                   value: checkboxValue,
//                   onChanged: (val) async {
//                     print(val);
//                     setState(() {
//                       // checkboxValue = val!;
//                       checkboxValue = !checkboxValue;
//                     });
//                     await widget.finishTask(
//                         widget.task.taskID, widget.task.taskStatus);
//                   }),
//               // SizedBox(width: 20),
//               // VerticalDivider(
//               //   color: Color(newblack),
//               //   thickness: 2,
//               // ),
//               Container(
//                 width: 320,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text('21'.tr),
//                               Text(': ${widget.task.taskName}'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text('22'.tr),
//                               Text(': ${widget.task.taskDescription}'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text('23'.tr),
//                               Text(': ${widget.task.taskStartDate}'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text('24'.tr),
//                               Text(': ${widget.task.taskEndDate}'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Padding(
//                     //   padding: const EdgeInsets.only(top: 50),
//                     //   child: TextButton(
//                     //       onPressed: () {},
//                     //       child: Text(
//                     //         'More',
//                     //         style: TextStyle(
//                     //             color: Color(newOrange), fontSize: 15),
//                     //       )),
//                     //)
//                     Column(
//                       children: [
//                         IconButton(
//                             onPressed: () async {
//                               await widget.deleteTask(widget.task.taskID);
//                             },
//                             icon: Icon(Icons.delete_forever_outlined)),
//                         IconButton(
//                             onPressed: () {
//                               print(widget.task.taskID);
//                               Get.to(StudentEditTask(
//                                 id: widget.task.taskID,
//                               ));
//                             },
//                             icon: Icon(Icons.edit))
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
//             child: Divider(
//               color: Color(newblack),
//               thickness: 2,
//             ),
//           )
//         ],
//       ),
//       // child: Column(
//       //   crossAxisAlignment: CrossAxisAlignment.start,
//       //   children: [
//       //     Row(
//       //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //       children: [
//       //         Checkbox(
//       //             checkColor: Color(newOrange),
//       //             activeColor: Colors.white,
//       //             value: checkboxValue,
//       //             onChanged: (val) async {
//       //               print(val);
//       //               setState(() {
//       //                 // checkboxValue = val!;
//       //                 checkboxValue = !checkboxValue;
//       //               });
//       //               await widget.finishTask(
//       //                   widget.task.taskID, widget.task.taskStatus);
//       //             }),
//       //         Container(
//       //           width: 340,
//       //           height: 160,
//       //           decoration: BoxDecoration(
//       //             color: Color(newDustyBlue),
//       //             borderRadius: BorderRadius.circular(20),
//       //           ),
//       //           child: Row(
//       //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //             children: [
//       //               Padding(
//       //                 padding: const EdgeInsets.all(12),
//       //                 child: Column(
//       //                   mainAxisAlignment: MainAxisAlignment.start,
//       //                   children: [
//       //                     Row(
//       //                       children: [
//       //                         Text('21'.tr),
//       //                         Text(': ${widget.task.taskName}'),
//       //                       ],
//       //                     ),
//       //                     Row(
//       //                       children: [
//       //                         Text('22'.tr),
//       //                         Text(': ${widget.task.taskDescription}'),
//       //                       ],
//       //                     ),
//       //                     Row(
//       //                       children: [
//       //                         Text('23'.tr),
//       //                         Text(': ${widget.task.taskStartDate}'),
//       //                       ],
//       //                     ),
//       //                     Row(
//       //                       children: [
//       //                         Text('24'.tr),
//       //                         Text(': ${widget.task.taskEndDate}'),
//       //                       ],
//       //                     ),
//       //                   ],
//       //                 ),
//       //               ),
//       //               Column(
//       //                 children: [
//       //                   IconButton(
//       //                       onPressed: () async {
//       //                         await widget.deleteTask(widget.task.taskID);
//       //                       },
//       //                       icon: Icon(Icons.delete_forever_outlined)),
//       //                   IconButton(
//       //                       onPressed: () {
//       //                         print(widget.task.taskID);
//       //                         Get.to(StudentEditTask(
//       //                           id: widget.task.taskID,
//       //                         ));
//       //                       },
//       //                       icon: Icon(Icons.edit))
//       //                 ],
//       //               )
//       //             ],
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }
