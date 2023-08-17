import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/task.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';
import 'package:newstart/studentScreens/tasks.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';
import 'addTask.dart';

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

  Future<void> getAllTasks() async {
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Task had been deleted successfully",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error! something went wrong.",
          style: TextStyle(fontSize: 20),
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
        content: Text(
          "Done",
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
      backgroundColor: Color(white),
      resizeToAvoidBottomInset: false,
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 330, top: 30),
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
                padding: const EdgeInsets.only(right: 200, top: 10),
                child: Text(
                  'My Tasks',
                  style: TextStyle(
                      color: Color(black),
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              posts.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 210),
                      child: Center(
                        child: Text('Empty',
                            style: TextStyle(
                                fontSize: 25, color: Colors.grey.shade700)),
                      ),
                    )
                  : Expanded(
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

                            return TaskStudent(
                                task: task,
                                deleteTask: deleteTask,
                                finishTask: finishTask);
                          }),
                    ),
            ],
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddTask(posts: posts, getAllTasks: getAllTasks));
          },
          backgroundColor: Color(NewDarkBlue),
          label: Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
                color: Color(NewDarkBlue),
                borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.add,
              color: Color(white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
