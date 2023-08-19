import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/Controller/changeDate.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/constant/appliApis.dart';
import 'package:newstart/store/getProducts.dart';
import 'package:newstart/student/notificationsstudent.dart';
import 'package:newstart/student/requestInfo.dart';
import 'package:newstart/studentScreens/consultationPatients.dart';
import 'package:newstart/studentScreens/getPatients.dart';
import 'package:newstart/studentScreens/getStudentRequests.dart';
import 'package:newstart/studentScreens/showAllTasks.dart';
import 'package:newstart/studentScreens/showPersoonalWork.dart';
import 'package:newstart/studentScreens/studentRequest.dart';
import 'package:newstart/studentScreens/studentShowCalendar.dart';
import 'package:newstart/studentScreens/studentShowProfile.dart';

import '../chat/views/chat_view_patients.dart';
import '../choseLoginType.dart';
import '../lab/getAvailableTime.dart';
import '../locale/local_controller.dart';
import '../main.dart';

class HomePageForStudents extends StatefulWidget {
  @override
  State<HomePageForStudents> createState() => _HomePageForStudentsState();
}

class _HomePageForStudentsState extends State<HomePageForStudents> {
  int day = DateTime.now().day;
  int currentIndex = 0;
  ChangeDate changeDate =
      new ChangeDate(DateTime.now().month, DateTime.now().weekday);

  List myRequest = [];

  bool isLoading = false;

  GetPost getPost = GetPost();

  getMyRequets() async {
    isLoading = true;
    setState(() {});

    var response = await getPost.getRequest('${url}/api/ViewMyRequests', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response['message'] == 'these are your requests') {
      print('got your requests');
      myRequest.addAll(response['data']);
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    MyLocalController controllerLang = Get.find();
    return Scaffold(
      backgroundColor: Color(white),
      drawer: Drawer(
        backgroundColor: Color(NewDarkBlue),
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(Icons.person_2_outlined, color: Colors.white, size: 30),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {
                      Get.off(StudentProfile());
                    },
                    child: Text('7'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 17)))
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(Icons.logout_outlined, color: Colors.white, size: 30),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {
                      studentSharedPreferences.clear();
                      Get.off(ChoseLoginType());
                    },
                    child: Text('8'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 17)))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text('9'.tr, style: TextStyle(color: Color(white), fontSize: 16)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color(white),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                ),
                onPressed: () {
                  controllerLang.changeLanguage('ar');
                },
                child:
                    Text('10'.tr, style: TextStyle(color: Color(NewDarkBlue)))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color(white),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                ),
                onPressed: () {
                  controllerLang.changeLanguage('en');
                },
                child:
                    Text('11'.tr, style: TextStyle(color: Color(NewDarkBlue)))),
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu_rounded),
                      iconSize: 30,
                    );
                  }),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(NotificationStudentView());
                        },
                        icon: Icon(Icons.notifications_none_sharp),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(ChatViewPatients());
                        },
                        icon: Icon(Icons.chat_bubble_outline_outlined),
                        iconSize: 30,
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi Dr. ',
                          style: TextStyle(color: Color(black), fontSize: 25),
                        ),
                        Text('${studentSharedPreferences.getString('name')}',
                            style: TextStyle(color: Color(black), fontSize: 25))
                      ],
                    ),
                    SizedBox(height: 5),
                    Text("Have a nice day",
                        style: TextStyle(
                            color: Color(black),
                            fontSize: 25,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  '${changeDate.getWeekName()} , ${changeDate.getMonthName()} , ${day}',
                  style: TextStyle(color: Colors.grey.shade900, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                    color: Color(0xffDDE9F8),
                    //border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Looking for the right patient?',
                        style: TextStyle(
                            color: Color(black),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'We will find your best match',
                        style: TextStyle(color: Color(black), fontSize: 18),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(StudentRequest());
                          },
                          child: Center(
                            child: Text(
                              'Send request',
                              style: TextStyle(
                                  color: Color(newOrange), fontSize: 16),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              //side: BorderSide(color: Colors.black, width: 1),
                              foregroundColor: Colors.black,
                              backgroundColor: Color(white),
                              elevation: 2,
                              //padding: EdgeInsets.all(10),
                              fixedSize: Size(200, 10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Already made a request ?',
                    style: TextStyle(
                        color: Color(black),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(GetStudentRequest());
                      },
                      child: Text(
                        'Check it',
                        style: TextStyle(color: Color(newOrange), fontSize: 18),
                      ))
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Also, check your:",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(ShowTasks());
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                'icons/note.png',
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tasks',
                                style: TextStyle(
                                    color: Color(white),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              //side: BorderSide(color: Colors.black, width: 1),
                              foregroundColor: Colors.black,
                              backgroundColor: Color(0xff153762),
                              elevation: 5,
                              padding: EdgeInsets.all(10),
                              fixedSize: Size(160, 120)),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(GetPatients());
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                'icons/clipboard-user (2).png',
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Patients',
                                style: TextStyle(
                                    color: Color(white),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              //side: BorderSide(color: Colors.black, width: 1),
                              foregroundColor: Colors.black,
                              backgroundColor: Color(0xff153762),
                              elevation: 5,
                              padding: EdgeInsets.all(10),
                              fixedSize: Size(160, 120)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(StudentPersonalWork());
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                'icons/teeth-open.png',
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Work',
                                style: TextStyle(
                                    color: Color(white),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              //side: BorderSide(color: Colors.black, width: 1),
                              foregroundColor: Colors.black,
                              backgroundColor: Color(0xff153762),
                              elevation: 5,
                              padding: EdgeInsets.all(10),
                              fixedSize: Size(160, 120)),
                        ),
                        SizedBox(width: 10),
                        studentSharedPreferences.getString('type') ==
                                'Master_Degree'
                            ? ElevatedButton(
                                onPressed: () {
                                  Get.to(ConsultationPatients());
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                      'icons/laptop-medical.png',
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Consult',
                                      style: TextStyle(
                                          color: Color(white),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    //side: BorderSide(color: Colors.black, width: 1),
                                    foregroundColor: Colors.black,
                                    backgroundColor: Color(0xff153762),
                                    elevation: 5,
                                    padding: EdgeInsets.all(10),
                                    fixedSize: Size(160, 120)),
                              )
                            : SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(paletsBackground),
        currentIndex: currentIndex,
        selectedLabelStyle: TextStyle(color: Color(darkBlue)),
        onTap: (value) {
          setState(() {
            currentIndex = value;

            if (currentIndex == 1) {
              Get.to(ShowStudentCalendar());
            } else if (currentIndex == 2) {
              Get.off(GetStoreProducts());
            } else if (currentIndex == 3) {
              Get.off(GetAvailableTime());
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'icons/home.png',
                height: 25,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'icons/calendar.png',
                height: 25,
              ),
              label: 'calendar'),
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/shopping-cart-add.png',
              height: 25,
            ),

            // Image.asset('icons/shopping-cart-add.png'),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/teeth-open1.png',
              height: 25,
            ),
            label: 'X-ray',
          ),
        ],
      ),
    );
  }
}
