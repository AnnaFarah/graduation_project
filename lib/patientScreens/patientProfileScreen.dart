import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/homePageForPatients.dart';
import 'package:newstart/patientClasses/patientProfile.dart';
import 'package:newstart/patientScreens/patientUpdateProfile.dart';

import '../constant/appliApis.dart';
import '../main.dart';

class PatientProfileScreen extends StatefulWidget {
  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  GetPost getPost = GetPost();

  bool isLoading = false;

  int currentIndex = 1;

  bool phoneNumber = false;
  bool region = false;

  late PatientProfile patientProfile = PatientProfile(
      name: 'name', description: 'description', age: 'age', gender: 'gender');

  TextEditingController phoneController = TextEditingController();
  TextEditingController regionController = TextEditingController();

  _showPatientProfile() async {
    isLoading = true;
    setState(() {});
    var responseBody = await getPost.getRequest(
        '${url}/api/ShowPatientProfile/${patientSharedPreferences.getString('id').toString()}',
        {
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${patientSharedPreferences.getString('token')}'
        });
    isLoading = false;
    setState(() {});
    if (responseBody['message'] == "This is your profile") {
      print('flutter: got your profile');
      patientProfile = PatientProfile(
          name: responseBody['data']['name'],
          //phoneNumber: responseBody['data']['phone'],
          description: responseBody['data']['description'],
          // region: responseBody['data']['Region'],
          age: responseBody['data']['age'],
          gender: responseBody['data']['gender']);
    } else {
      print('flutter: error getting your profile');
    }
  }

  @override
  void initState() {
    _showPatientProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(navyBlue),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: Color(navyBlue),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 150,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('images/profilePic.png'),
                            radius: 50,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit_outlined),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(background2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 25),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  //name
                                  '25'.tr,
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${patientProfile.name}",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  //age
                                  '26'.tr,
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${patientProfile.age}",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  //gender
                                  '27'.tr,
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${patientProfile.gender}",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  //description
                                  '22'.tr,
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${patientProfile.description}",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            phoneNumber == true
                                ? Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            //phone number
                                            '39'.tr,
                                            style: TextStyle(
                                                color: Color(navyBlue),
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "${patientProfile.phoneNumber}",
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 17),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            region == true
                                ? Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            //region
                                            '49'.tr,
                                            style: TextStyle(
                                                color: Color(navyBlue),
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "${patientProfile.region}",
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 17),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.off(PatientUpdateProfile(
                                        patientProfile: patientProfile));
                                  },
                                  icon: Icon(Icons.update_sharp),
                                  color: Color(green),
                                ),
                                Text(
                                  //update phone number or region
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
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedLabelStyle: TextStyle(color: Color(darkBlue)),
        onTap: (value) {
          setState(() {
            currentIndex = value;
            if (currentIndex == 0) {
              Get.off(HomePageForPatients());
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Color(navyBlue),
              ),
              label: ''),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              color: Color(navyBlue),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
