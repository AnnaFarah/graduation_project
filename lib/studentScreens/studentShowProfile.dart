import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/student/profileInfo.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';
import 'package:newstart/studentScreens/studentUpdateProfile.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class StudentProfile extends StatefulWidget {
  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  GetPost getPost = GetPost();

  bool isLoading = false;

  int currentIndex = 2;

  late StudentProfileInfo studentProfileInfo;

  _showStudentProfile() async {
    isLoading = true;
    setState(() {});

    var responseBody =
        await getPost.getRequest('${url}/api/ShowStudentProfile/1', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});
    if (responseBody['message'] == "This is your profile") {
      print('flutter : got your profile');
      studentProfileInfo =
          StudentProfileInfo(name: responseBody['data']['name']);
    } else {
      print('flutter: error getting your profile');
    }
  }

  @override
  void initState() {
    _showStudentProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  color: Color(newBeige),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200, left: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Name: ',
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${studentProfileInfo.name}",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 400,
                                            child: Center(child: Builder(
                                              builder: (context) {
                                                return StudentUpdateProfile(
                                                    studentProfileInfo:
                                                        studentProfileInfo);
                                              },
                                            )),
                                          );
                                        });
                                    // Get.off(StudentUpdateProfile(
                                    //     studentProfileInfo:
                                    //         studentProfileInfo));
                                  },
                                  icon: Icon(Icons.update_sharp),
                                  iconSize: 30,
                                  color: Color(newOrange),
                                ),
                                Text(
                                  '50'.tr,
                                  style: TextStyle(
                                      fontSize: 15, color: Color(navyBlue)),
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(newDarkBlue),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 300),
                    child: IconButton(
                      onPressed: () {
                        Get.off(HomePageForStudents());
                      },
                      icon: Icon(Icons.arrow_back),
                      iconSize: 40,
                    ),
                  ),
                ),
                Positioned(
                    top: 100,
                    left: 160,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('icons/user.png'),
                      backgroundColor: Colors.white,
                      radius: 45,
                    ))
              ],
            ),
    );
  }
}
