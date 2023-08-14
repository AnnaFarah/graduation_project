import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newstart/patientScreens/patientProfileScreen.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';
import '../patientClasses/patientProfile.dart';

class PatientUpdateProfile extends StatefulWidget {
  final PatientProfile patientProfile;
  PatientUpdateProfile({required this.patientProfile});

  @override
  State<PatientUpdateProfile> createState() => _PatientUpdateProfileState();
}

class _PatientUpdateProfileState extends State<PatientUpdateProfile> {
  GlobalKey<FormState> formKey = GlobalKey();
  GetPost getPost = GetPost();
  late File _file;
  bool isLoading = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController regionController = TextEditingController();

  _updateProfile() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${patientSharedPreferences.getString('token')}'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${url}/api/UpdatePatientProfile/${patientSharedPreferences.getString('id').toString()}'));
    request.fields.addAll(
        {'phone': phoneController.text, 'Region': regionController.text});
    request.files
        .add(await http.MultipartFile.fromPath('photo', _file as String));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // isLoading = false;
    // setState(() {});
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('flutter : updated profile');
      Get.off(PatientProfileScreen());
    } else {
      print(response.reasonPhrase);
    }
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
                                  'Name: ',
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${widget.patientProfile.name}",
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
                                  'Age: ',
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${widget.patientProfile.age}",
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
                                  'Gender: ',
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${widget.patientProfile.gender}",
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
                                  'Description: ',
                                  style: TextStyle(
                                      color: Color(navyBlue), fontSize: 20),
                                ),
                                Text(
                                  "${widget.patientProfile.description}",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: phoneController,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.phone,
                                            color: Color(navyBlue),
                                            size: 30,
                                          ),
                                          hintText: "Phone number",
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w300),
                                          border: InputBorder.none),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 30),
                                      child: Divider(
                                        color: Colors.grey.shade400,
                                        thickness: 2,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      controller: regionController,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.home,
                                            color: Color(navyBlue),
                                            size: 30,
                                          ),
                                          hintText: "Region",
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w300),
                                          border: InputBorder.none),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 30),
                                      child: Divider(
                                        color: Colors.grey.shade400,
                                        thickness: 2,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await _updateProfile();
                                        },
                                        child: Text('confirm'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(navyBlue),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 120)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.off(PatientProfileScreen());
                                        },
                                        child: Text('Cancel'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 120)),
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
