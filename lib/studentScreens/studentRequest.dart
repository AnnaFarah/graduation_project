import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/homePageFroStudents.dart';
import 'package:newstart/studentScreens/student_home_page.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class StudentRequest extends StatefulWidget {
  @override
  State<StudentRequest> createState() => _StudentRequestState();
}

class _StudentRequestState extends State<StudentRequest> {
  GlobalKey<FormState> formKey = GlobalKey();
  //TextEditingController titleController = TextEditingController();
  //TextEditingController subjectController = TextEditingController();
  String priority = 'low';
  String subject = 'أمراض فم 1';
  String specialization = 'طب أسنان الأطفال';
  var chosenID;
  List clinicalConditions = [];
  bool gotConditions = false;

  String year = 'first';
  GetPost getPost = GetPost();
  bool isLoading = false;

  getDisease(String type) async {
    isLoading = true;
    setState(() {});
    var response = await getPost
        .getRequest('${url}/api/ShowClinicalConidition/${year}/${type}', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});
    if (response['message'] == 'this are ClinicalConiditions') {
      gotConditions = true;
      print('flutter : got your clinical conditions');
      clinicalConditions.clear();
      clinicalConditions.addAll(response['data']);
      print('flutter : response body ${clinicalConditions}');
    }
  }

  sendRequest(bool master) async {
    isLoading = true;
    setState(() {});
    print('ID : ${chosenID}');
    print('priority : ${priority}');
    print('specialization: ${specialization}');
    print('subject: ${subject}');
    print('year : ${year}');
    if (master == true) {
      var response = await getPost.postRequest(makeRequestApi, {
        'year': year,
        'subject': '',
        'priority': priority,
        'disease_name_id': chosenID.toString(),
        'specializations': specialization
      }, {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
      });
      isLoading = false;
      setState(() {});
      if (response['message'] == 'your request has been added') {
        print('flutter: request sent');
        Get.off(HomePageS());
      } else {
        print('flutter: error sending request');
      }
    } else {
      var response = await getPost.postRequest(makeRequestApi, {
        'year': year,
        'subject': subject,
        'priority': priority,
        'disease_name_id': chosenID.toString(),
        'specializations': ''
      }, {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
      });

      isLoading = false;
      setState(() {});
      if (response['message'] == 'your request has been added') {
        print('flutter: request sent');
        Get.off(HomePageS());
      } else {
        print('flutter: error sending request');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(NewLightBlue),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(color: Color(NewLightBlue)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.off(HomePageForStudents());
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Color(NewDarkBlue),
                          iconSize: 30,
                        ),
                        Center(
                          child: Text(
                            'Send request'.tr,
                            style: TextStyle(
                                color: Color(NewDarkBlue), fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ))),
          Form(
            key: formKey,
            child: Expanded(
              flex: 6,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(white),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 20, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Priority:",
                                style: TextStyle(
                                    color: Color(black),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 160,
                              ),
                              DropdownButton(
                                hint: Text('low'),
                                items: ['low', 'medium', 'hight']
                                    .map((e) => DropdownMenuItem(
                                        child: Text('$e'), value: e))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    priority = val!;
                                  });
                                },
                                value: priority,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(children: [
                            Text(
                              "Specialization:",
                              style: TextStyle(
                                  color: Color(black),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            studentSharedPreferences.getString('type') ==
                                    'Master_Degree'
                                ? DropdownButton(
                                    hint: Text('طب أسنان الأطفال'),
                                    items: [
                                      'جراحة',
                                      'طب أسنان الأطفال',
                                      'طب الفم',
                                      'تقويم',
                                      'لثة',
                                      'تعويضات المتحركة',
                                      'تعويضات الثابتة',
                                      'تجميل',
                                      'لبية'
                                    ]
                                        .map((e) => DropdownMenuItem(
                                            child: Text('$e'), value: e))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        specialization = val!;
                                      });
                                    },
                                    value: specialization,
                                  )
                                : DropdownButton(
                                    hint: Text('ترميمية'),
                                    items: [
                                      'أمراض فم 1',
                                      'مداواة لبية1',
                                      'تخدير وقلع1',
                                      'تعويضات متحركة',
                                      'أمراض نسج حول سنية',
                                      'تقويم 1',
                                      'ترميمية',
                                      'أمراض فم 2',
                                      'مداواة لبية2',
                                      'تقويم 2',
                                      'تخدير وقلع2',
                                      'تعويضات متحركة',
                                      'تعويضات ثابتة',
                                      'طب أسنان أطفال',
                                      'أمراض فم2',
                                      'تخدير وقلع',
                                      'تعويضات متحركة',
                                      'مداواة لبية',
                                      'تعويضات ثابتة',
                                      'زرع',
                                      'تقويم 3'
                                    ]
                                        .map((e) => DropdownMenuItem(
                                            child: Text('$e'), value: e))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        subject = val!;
                                      });
                                    },
                                    value: subject,
                                  ),
                          ]),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Year:",
                                style: TextStyle(
                                    color: Color(black),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 190,
                              ),
                              studentSharedPreferences.getString('type') ==
                                      'Master_Degree'
                                  ? DropdownButton(
                                      hint: Text('first'),
                                      items: ['first', 'second', 'third']
                                          .map((e) => DropdownMenuItem(
                                              child: Text('$e'), value: e))
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          year = val!;
                                        });
                                      },
                                      value: year,
                                    )
                                  : DropdownButton(
                                      hint: Text('fourth'),
                                      items: ['fourth', 'fifth']
                                          .map((e) => DropdownMenuItem(
                                              child: Text('$e'), value: e))
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          year = val!;
                                        });
                                      },
                                      value: year,
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          studentSharedPreferences.getString('type') ==
                                  'Master_Degree'
                              ? Center(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await getDisease(specialization);
                                      },
                                      child: Text('19'.tr),
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          backgroundColor: Color(NewDarkBlue),
                                          fixedSize: Size(250, 40))),
                                )
                              : Center(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await getDisease(subject);
                                      },
                                      child: Text('19'.tr),
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          backgroundColor: Color(NewDarkBlue),
                                          fixedSize: Size(250, 40))),
                                ),
                          gotConditions == true
                              ? Flexible(
                                  child: ListView.builder(
                                      itemCount: clinicalConditions.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) => TextButton(
                                          onPressed: () {
                                            setState(() {
                                              chosenID =
                                                  clinicalConditions[i]['id'];
                                            });
                                          },
                                          child: Text(
                                            '${clinicalConditions[i]['clinical_condition']}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))))
                              : SizedBox(),
                          gotConditions == true &&
                                  studentSharedPreferences.getString('type') ==
                                      'Master_Degree'
                              ? Center(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await sendRequest(true);
                                      },
                                      child: Text('37'.tr),
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          backgroundColor: Color(NewDarkBlue),
                                          fixedSize: Size(250, 40))),
                                )
                              : SizedBox(),
                          gotConditions == true &&
                                  studentSharedPreferences.getString('type') ==
                                      'Bachelor_Degree'
                              ? Center(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await sendRequest(false);
                                      },
                                      child: Text('37'.tr),
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          backgroundColor: Color(NewDarkBlue),
                                          fixedSize: Size(250, 40))),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
