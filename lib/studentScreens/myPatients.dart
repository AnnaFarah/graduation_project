import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/student/myPatientsInfo.dart';
import 'package:newstart/studentScreens/addPrescription.dart';
import 'package:newstart/studentScreens/addRecord.dart';
import 'package:newstart/studentScreens/showRecords.dart';
import 'package:newstart/studentScreens/student_home_page.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class MyPatients extends StatefulWidget {
  @override
  State<MyPatients> createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  GetPost getPost = GetPost();
  List listOfPatients = [];

  final TextEditingController diseaseName = TextEditingController();

  final TextEditingController description = TextEditingController();

  final TextEditingController startDate = TextEditingController();

  final TextEditingController endDate = TextEditingController();

  getMyPatients() async {
    isLoading = true;
    setState(() {});

    var responseBody = await getPost.getRequest(getMyPatientsApi, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (responseBody['message'] == "These are your patients") {
      listOfPatients.addAll(responseBody['data']);
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

  Future<void> addPrescription(int patientID) async {
    isLoading = true;
    setState(() {});
    print('disease name : ${diseaseName.text}');
    print('diseaseName  : ${diseaseName.text}');
    print('starting_date : ${startDate.text}');
    var response = await getPost
        .postRequest('http://10.0.2.2:8000/api/AddPrescription/${patientID}', {
      'disease_name': diseaseName.text,
      'description': description.text,
      'starting_date': startDate.text,
      'end_date': endDate.text,
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});

    if (response['message'] ==
        "your prescription has been added successfully ") {
      print("flutter: added prescription");
    } else {
      print('flutter: error adding prescription');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: listOfPatients.isEmpty
            ? Text('30'.tr)
            : Form(
                child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(newLightBeige), Color(newDustyBlue)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
                child: Column(
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
                    Padding(
                      padding: const EdgeInsets.only(right: 250, top: 20),
                      child: Text('4'.tr,
                          style: TextStyle(
                              fontFamily: 'cookie',
                              color: Colors.black,
                              fontSize: 35)),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: listOfPatients.length,
                          itemBuilder: (context, i) {
                            MyPatientsInfo myPatientsInfo = MyPatientsInfo(
                                id: listOfPatients[i]['id'],
                                name: listOfPatients[i]['name'],
                                age: listOfPatients[i]['age'],
                                gender: listOfPatients[i]['gender'],
                                description: listOfPatients[i]['description'],
                                userID: listOfPatients[i]['user_id']);
                            return ShowPatients(
                                diseaseName: diseaseName,
                                description: description,
                                startDate: startDate,
                                endDate: endDate,
                                myPatientsInfo: myPatientsInfo,
                                addPrescription: addPrescription);
                          }),
                    ),
                  ],
                ),
              )));
  }
}

class ShowPatients extends StatefulWidget {
  final TextEditingController diseaseName;
  final TextEditingController description;
  final TextEditingController startDate;
  final TextEditingController endDate;
  final MyPatientsInfo myPatientsInfo;
  final Future<void> Function(int) addPrescription;
  const ShowPatients(
      {required this.diseaseName,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.myPatientsInfo,
      required this.addPrescription,
      super.key});
  @override
  State<ShowPatients> createState() => _ShowPatientsState();
}

class _ShowPatientsState extends State<ShowPatients> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('icons/file-user.png', height: 40),
                Container(
                  width: 310,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(newBeige),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('25'.tr),
                                  Text(': ${widget.myPatientsInfo.name}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('26'.tr),
                                  Text(': ${widget.myPatientsInfo.age}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('27'.tr),
                                  Text(': ${widget.myPatientsInfo.gender}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('15'.tr),
                                  Text(
                                      ': ${widget.myPatientsInfo.description}'),
                                ],
                              )
                            ]),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.off(ShowRecord(id: widget.myPatientsInfo.id));
                        },
                        icon: Icon(Icons.arrow_right),
                        iconSize: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250),
            child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 400,
                            child: Center(
                              child: Builder(builder: (context) {
                                return AddPrescription1(
                                    id: widget.myPatientsInfo.id);
                              }),
                            ));
                      });
                },
                child: Text(
                  '28'.tr,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250),
            child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 400,
                            child: Center(
                              child: Builder(builder: (context) {
                                return AddRecord(id: widget.myPatientsInfo.id);
                              }),
                            ));
                      });
                },
                child: Text(
                  '29'.tr,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.grey.shade500,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
