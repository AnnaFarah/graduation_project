import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/store/getProducts.dart';
import 'package:newstart/studentScreens/consultationPatients.dart';
import 'package:newstart/studentScreens/myPatients.dart';
import 'package:newstart/studentScreens/showAllTasks.dart';
import 'package:newstart/studentScreens/showPersoonalWork.dart';
import 'package:newstart/studentScreens/studentRequest.dart';
import 'package:newstart/studentScreens/studentShowCalendar.dart';
import 'package:newstart/studentScreens/studentShowProfile.dart';

import '../choseLoginType.dart';
import '../lab/getAvailableTime.dart';
import '../locale/local_controller.dart';
import '../main.dart';

class HomePageS extends StatefulWidget {
  @override
  State<HomePageS> createState() => _HomePageSState();
}

class _HomePageSState extends State<HomePageS> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    MyLocalController controllerLang = Get.find();
    return Scaffold(
      backgroundColor: Color(paletsBackground),
      drawer: Drawer(
        backgroundColor: Color(newDarkBlue),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(children: [
            Row(
              children: [
                Icon(Icons.person_2_outlined, color: Colors.white, size: 30),
                TextButton(
                    onPressed: () {
                      Get.off(StudentProfile());
                    },
                    child: Text('7'.tr,
                        style: TextStyle(
                          color: Colors.white,
                        )))
              ],
            ),
            Row(
              children: [
                Icon(Icons.logout_outlined, color: Colors.white, size: 30),
                TextButton(
                    onPressed: () {
                      studentSharedPreferences.clear();
                      Get.off(ChoseLoginType());
                    },
                    child: Text('8'.tr,
                        style: TextStyle(
                          color: Colors.white,
                        )))
              ],
            ),
            Text('9'.tr),
            ElevatedButton(
                onPressed: () {
                  controllerLang.changeLanguage('ar');
                },
                child: Text('10'.tr)),
            ElevatedButton(
                onPressed: () {
                  controllerLang.changeLanguage('en');
                },
                child: Text('11'.tr)),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu_outlined),
                  iconSize: 30,
                );
              }),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.message),
                    iconSize: 30,
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  '52'.tr,
                  style: TextStyle(fontSize: 30),
                ),
                Text(', ${studentSharedPreferences.getString('name')}',
                    style: TextStyle(fontSize: 30))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Center(
                child: Image.asset(
              'images/student_home_page.JPG',
              height: 220,
              //width: 800,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Text(
              '53'.tr,
              style: TextStyle(fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 220),
            child: ElevatedButton(
              onPressed: () {
                Get.to(StudentRequest());
              },
              child: Text(
                '5'.tr,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color(newOrange),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 230, top: 20),
            child: Text(
              '54'.tr,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(ShowTasks());
                  },
                  child: Text('2'.tr),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      side: BorderSide(color: Colors.black, width: 1),
                      foregroundColor: Colors.black,
                      backgroundColor: Color(paletsBackground),
                      elevation: 4,
                      padding: EdgeInsets.all(10),
                      fixedSize: Size(160, 120)),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.off(MyPatients());
                  },
                  child: Text('4'.tr),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      side: BorderSide(color: Colors.black, width: 1),
                      foregroundColor: Colors.black,
                      backgroundColor: Color(paletsBackground),
                      elevation: 4,
                      padding: EdgeInsets.all(10),
                      fixedSize: Size(160, 120)),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(StudentPersonalWork());
                  },
                  child: Text('3'.tr),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      side: BorderSide(color: Colors.black, width: 1),
                      foregroundColor: Colors.black,
                      backgroundColor: Color(paletsBackground),
                      elevation: 4,
                      padding: EdgeInsets.all(10),
                      fixedSize: Size(160, 120)),
                ),
                SizedBox(
                  width: 10,
                ),
                studentSharedPreferences.getString('type') == 'Master_Degree'
                    ? ElevatedButton(
                        onPressed: () {
                          Get.to(ConsultationPatients());
                        },
                        child: Text('6'.tr),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            side: BorderSide(color: Colors.black, width: 1),
                            foregroundColor: Colors.black,
                            backgroundColor: Color(paletsBackground),
                            elevation: 4,
                            padding: EdgeInsets.all(10),
                            fixedSize: Size(140, 120)),
                      )
                    : SizedBox()
              ]),
            ),
          )
        ]),
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
              'icons/teeth-open.png',
              height: 25,
            ),
            label: 'X-ray',
          ),
        ],
      ),
    );
  }
}
