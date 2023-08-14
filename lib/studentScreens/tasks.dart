import 'package:flutter/material.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xffE4ECF6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          focusColor: Color(white),
                          checkColor: Color(0xff3E4685),
                          activeColor: Colors.white,
                          value: checkboxValue,
                          onChanged: (val) async {
                            print(val);
                            setState(() {
                              // checkboxValue = val!;
                              checkboxValue = !checkboxValue;
                            });
                            await widget.finishTask(
                                widget.task.taskID, widget.task.taskStatus);
                          }),
                      SizedBox(width: 10),
                      VerticalDivider(
                        color: Color(newblack),
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                //Text('21'.tr),
                                Text('${widget.task.taskName}'),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text('22'.tr),
                            //     Text(': ${widget.task.taskDescription}'),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                //Text('23'.tr),
                                Text('${widget.task.taskStartDate}'),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text('24'.tr),
                            //     Text(': ${widget.task.taskEndDate}'),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await widget.deleteTask(widget.task.taskID);
                              },
                              icon: Icon(Icons.delete_forever_outlined)),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Container(
                                          width: 200,
                                          height: 200,
                                          child: AlertDialog(
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                            content: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Task name:',
                                                  style: TextStyle(
                                                      color: Color(0xff3E4685),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 10),
                                                Text('${widget.task.taskName}'),
                                                SizedBox(height: 30),
                                                Text(
                                                  'Description:',
                                                  style: TextStyle(
                                                      color: Color(0xff3E4685),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 10),
                                                Text('${widget.task.taskName}'),
                                                SizedBox(height: 30),
                                                Text(
                                                  'Start date:',
                                                  style: TextStyle(
                                                      color: Color(0xff3E4685),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 10),
                                                Text('${widget.task.taskName}'),
                                                SizedBox(height: 30),
                                                Text(
                                                  'End date:',
                                                  style: TextStyle(
                                                      color: Color(0xff3E4685),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(height: 10),
                                                Text('${widget.task.taskName}'),
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: Text(
                                'Show more',
                                style: TextStyle(
                                    color: Color(0xff3E4685), fontSize: 15),
                              )),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     IconButton(
                      //         onPressed: () async {
                      //           await widget.deleteTask(widget.task.taskID);
                      //         },
                      //         icon: Icon(Icons.delete_forever_outlined)),
                      //     IconButton(
                      //         onPressed: () {
                      //           print(widget.task.taskID);
                      //          Get.to(StudentEditTask(
                      //             id: widget.task.taskID,
                      //           ));
                      //         },
                      //         icon: Icon(Icons.edit))
                      //   ],
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
