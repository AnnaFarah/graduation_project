import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appliApis.dart';
import 'package:newstart/patient/consulation.dart';
import 'package:newstart/studentScreens/student_home_page.dart';

import '../constant/appColor.dart';
import '../main.dart';
import '../tryCalendar.dart';
import 'transferPatient.dart';

class ConsultationPatients extends StatefulWidget {
  @override
  State<ConsultationPatients> createState() => _ConsultationPatientsState();
}

class _ConsultationPatientsState extends State<ConsultationPatients> {
  GlobalKey<FormState> formKey = GlobalKey();

  GetPost getPost = GetPost();
  List posts = [];
  bool isLoading = false;

  getAllPatients() async {
    isLoading = true;
    setState(() {});
    var responseBody = await getPost.getRequest('${url}/api/myConsultations', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});
    if (responseBody['message'] == "These are your Consultations") {
      print('response body: ${responseBody}');
      //var listData = responseBody['data'];
      //print('list data: ${listData}');
      posts.addAll(responseBody['data']);
      print("flutter : success adding to the list patients");
      //print("posts: ${posts[1]}");
    } else {
      print('flutter : error showing patients');
    }
  }

  @override
  void initState() {
    getAllPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: posts.isEmpty
          ? Text('30'.tr)
          : Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 300, top: 20),
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
                  Center(
                    child: Text('6'.tr,
                        style: TextStyle(
                            fontFamily: 'cookie',
                            color: Colors.black,
                            fontSize: 43)),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, i) {
                          ConsulateInfo consulateInfo = ConsulateInfo(
                              id: posts[i]['id'],
                              patientID: posts[i]['patient_id'],
                              isDone: posts[i]['is_done'],
                              description: posts[i]['description'],
                              phoneNumber: posts[i]['phoneNumber'],
                              type: posts[i]['type']);

                          return EditTaskItem(
                            consulateInfo: consulateInfo,
                          );
                        }),
                  ),
                ],
              )),
    );
  }
}

class EditTaskItem extends StatefulWidget {
  final ConsulateInfo consulateInfo;

  const EditTaskItem({required this.consulateInfo, super.key});

  @override
  State<EditTaskItem> createState() => _EditTaskItemState();
}

class _EditTaskItemState extends State<EditTaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(newBeige),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('38'.tr),
                            Text(': ${widget.consulateInfo.type}'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('39'.tr),
                            Text(': ${widget.consulateInfo.phoneNumber}'),
                          ],
                        ),
                        widget.consulateInfo.description == null
                            ? SizedBox()
                            : Row(
                                children: [
                                  Text('15'.tr),
                                  Text(': ${widget.consulateInfo.description}'),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    widget.consulateInfo.type == 'request'
                        ? SizedBox()
                        : TextButton(
                            onPressed: () {
                              Get.to(ScrollList(id: widget.consulateInfo.id));
                            },
                            child: Text(
                              '40'.tr,
                              style: TextStyle(
                                  fontSize: 15, color: Color(newDarkBlue)),
                            )),
                    IconButton(
                      onPressed: () {
                        print('patient id: ${widget.consulateInfo.patientID}');
                        Get.to(CalendarStudent(
                            id: widget.consulateInfo.patientID));
                      },
                      icon: Icon(Icons.calendar_month_outlined),
                      iconSize: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
