import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/studentScreens/editTask.dart';

import '../component/task.dart';
import '../constant/appColor.dart';

class TaskStudent extends StatefulWidget {
  final Task task;
  final Future<void> Function(int) deleteTask;
  final Future<void> Function(int, int) finishTask;
  const TaskStudent(
      {required this.task,
      required this.deleteTask,
      required this.finishTask,
      super.key});
  @override
  State<TaskStudent> createState() => _TaskStudentState();
}

class _TaskStudentState extends State<TaskStudent> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                focusColor: Color(white),
                checkColor: Color(NewDarkBlue),
                activeColor: Colors.white,
                value: checkboxValue,
                onChanged: (val) async {
                  print(val);
                  setState(() {
                    checkboxValue = !checkboxValue;
                  });
                  await widget.finishTask(
                      widget.task.taskID, widget.task.taskStatus);
                },
              ),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task name:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${widget.task.taskName}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Description:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${widget.task.taskDescription}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await widget
                                                .deleteTask(widget.task.taskID);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                color: Color(newOrange),
                                                fontSize: 18),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                color: Colors.grey.shade800,
                                                fontSize: 18),
                                          )),
                                    ],
                                    content: Text(
                                      'Are you sure you want to delete?',
                                      style: TextStyle(color: Colors.black),
                                    )));
                      },
                      // onPressed: () async {

                      //   await widget.deleteTask(widget.task.taskID);
                      // },
                      icon: Icon(
                        Icons.delete_outlined,
                        size: 26,
                      )),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.to(
                                              EditTask(id: widget.task.taskID));
                                        },
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Color(newOrange),
                                              fontSize: 18),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontSize: 18),
                                        )),
                                  ],
                                  content: Container(
                                    width: 300,
                                    height: 330,
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Task name:',
                                            style: TextStyle(
                                                color: Color(NewDarkBlue),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10),
                                          Text('${widget.task.taskName}'),
                                          SizedBox(height: 30),
                                          Text(
                                            'Description:',
                                            style: TextStyle(
                                                color: Color(NewDarkBlue),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                              '${widget.task.taskDescription}'),
                                          SizedBox(height: 30),
                                          Text(
                                            'Start date:',
                                            style: TextStyle(
                                                color: Color(NewDarkBlue),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10),
                                          Text('${widget.task.taskStartDate}'),
                                          SizedBox(height: 30),
                                          Text(
                                            'End date:',
                                            style: TextStyle(
                                                color: Color(NewDarkBlue),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10),
                                          Text('${widget.task.taskEndDate}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: Text(
                        'Show more',
                        style: TextStyle(color: Color(newOrange), fontSize: 15),
                      )),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              thickness: 1,
              color: Color(black),
            ),
          ),
        ],
      ),
    );
  }
}
