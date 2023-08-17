import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/student/personalWordkInfo.dart';
import 'package:newstart/studentScreens/addPersonalWork.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';

import '../constant/appliApis.dart';
import '../main.dart';

class StudentPersonalWork extends StatefulWidget {
  @override
  State<StudentPersonalWork> createState() => _StudentPersonalWorkState();
}

class _StudentPersonalWorkState extends State<StudentPersonalWork> {
  bool isLoading = false;
  GetPost getPost = GetPost();
  List studentWork = [];

  showWork() async {
    isLoading = true;
    setState(() {});

    var response = await getPost.getRequest('${url}/api/ShowMyWorks', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response['message'] == "these are your personal works") {
      print('flutter: got your personal work');
      studentWork.addAll(response['data']);
      //print('work: ${work}');
    } else {
      print('flutter: error showing your work');
    }
  }

  @override
  void initState() {
    showWork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(white),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Get.off(HomePageForStudents());
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Color(black),
                ),
                Text(
                  '58'.tr,
                  style: TextStyle(fontSize: 25, color: Color(black)),
                ),
                IconButton(
                    onPressed: () {
                      Get.to(AddPersonalWork());
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            Divider(
              color: Color(black),
            ),
            studentWork.isEmpty
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
                        itemCount: studentWork.length,
                        itemBuilder: (context, i) {
                          PersonalWorkInfo personalWorkInfo = PersonalWorkInfo(
                              id: studentWork[i]['id'],
                              name: studentWork[i]['name'],
                              description: studentWork[i]['description'],
                              photo: studentWork[i]['photo'],
                              subject: studentWork[i]['subject_name']);
                          return Column(
                            children: [
                              Image.network(
                                personalWorkInfo.photo,
                                height: 100,
                                width: 300,
                              ),
                              Text('${personalWorkInfo.name}'),
                              Text('${personalWorkInfo.description}'),
                              Text('${personalWorkInfo.subject}'),
                            ],
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
