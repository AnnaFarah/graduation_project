import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/chat/controllers/chat_with_admin_controller.dart';
import 'package:newstart/main.dart';
import 'package:newstart/student/myPatientsInfo.dart';
import 'package:http/http.dart' as http;
import '../../component/getAndPost.dart';
import '../../constant/appColor.dart';
import '../../constant/appliApis.dart';
import 'chat_view.dart';

class ChatViewPatients extends StatefulWidget {
  const ChatViewPatients({Key? key}) : super(key: key);

  @override
  State<ChatViewPatients> createState() => _ChatViewPatientsState();
}

class _ChatViewPatientsState extends State<ChatViewPatients> {
  List listOfPatients = [];
  bool isLoading = false;
  GetPost getPost = GetPost();

  getMyPatients() async {
    isLoading = true;
    setState(() {});
    var responseBody =
        await http.get(Uri.parse('$url/api/mypatients'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});
    if (jsonDecode(responseBody.body)['message'] == "These are your patients") {
      listOfPatients.addAll(jsonDecode(responseBody.body)['data']);
      print('List of patients : ${listOfPatients}');
      print('flutter: done getting your patients');
    } else {
      print('flutter: could not get your patients');
    }
  }

  @override
  void initState() {
    getMyPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(newLightBeige), Color(newDustyBlue)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 300, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      // Get.off(HomePageStudent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(newOrange),
                    ),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 250, top: 20),
                  child: Text('My Patient:',
                      style: TextStyle(
                          fontFamily: 'cookie',
                          color: Colors.black,
                          fontSize: 35)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listOfPatients.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, i) {
                      MyPatientsInfo myPatientsInfo = MyPatientsInfo(
                        id: listOfPatients[i]['id'],
                        name: listOfPatients[i]['name'],
                        age: listOfPatients[i]['age'],
                        gender: listOfPatients[i]['gender'],
                        description: listOfPatients[i]['description'],
                        userID: listOfPatients[i]['user_id'],
                      );
                      return InkWell(
                        onTap: () {
                          Get.put(ChatController());
                          Get.to(
                            ChatView(
                              patient_id: listOfPatients[i]['id'],
                              doctor_id: int.parse(
                                  studentSharedPreferences.getString('id')!),
                              name: listOfPatients[i]['name'],
                              isDocotor: true,
                            ),
                            arguments: {
                              'patient_id': listOfPatients[i]['id'],
                              'doctor_id': int.parse(
                                  studentSharedPreferences.getString('id')!),
                              'name': listOfPatients[i]['name'],
                              'isDoctor': true,
                            },
                          );
                        },
                        child: PatientCard(
                          myPatientsInfo: myPatientsInfo,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  const PatientCard({
    Key? key,
    required this.myPatientsInfo,
  }) : super(key: key);

  final MyPatientsInfo myPatientsInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Image.asset(
            'icons/user.png',
            width: 25,
            alignment: Alignment.center,
          ),
          title: Text(myPatientsInfo.name),
          subtitle: Text(myPatientsInfo.age ?? ""),
          trailing: Icon(Icons.arrow_forward_rounded)),
    );
  }
}
