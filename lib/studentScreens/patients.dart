import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/student/myPatientsInfo.dart';
import 'package:newstart/studentScreens/addPrescription.dart';
import 'package:newstart/studentScreens/addRecord.dart';
import 'package:newstart/studentScreens/showRecords.dart';
import 'package:newstart/tryCalendar.dart';

import '../constant/appColor.dart';

class Patients extends StatefulWidget {
  final MyPatientsInfo myPatientsInfo;
  const Patients({required this.myPatientsInfo, super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Name:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${widget.myPatientsInfo.name}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Age:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${widget.myPatientsInfo.age}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                          color: Color(newOrange),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(AddRecord(id: widget.myPatientsInfo.id));
                            },
                            child: Text(
                              'Add record',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                          color: Color(newOrange),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(AddPrescription1(
                                  id: widget.myPatientsInfo.id));
                            },
                            child: Text(
                              'Add prescription',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(ShowRecord(id: widget.myPatientsInfo.id));
                      },
                      icon: Icon(
                        Icons.recent_actors_rounded,
                        size: 30,
                      )),
                  IconButton(
                    onPressed: () {
                      Get.to(CalendarStudent(id: widget.myPatientsInfo.userID));
                    },
                    icon: Image.asset(
                      'icons/calendar.png',
                      height: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontSize: 18),
                                        )),
                                  ],
                                  content: Container(
                                    width: 300,
                                    height: 330,
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Patient name:',
                                            style: TextStyle(
                                                color: Color(NewDarkBlue),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10),
                                          Text('${widget.myPatientsInfo.name}'),
                                          SizedBox(height: 30),
                                          Text(
                                            'Patient age:',
                                            style: TextStyle(
                                                color: Color(NewDarkBlue),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10),
                                          Text('${widget.myPatientsInfo.age}'),
                                          SizedBox(height: 30),
                                          Text(
                                            'Patient gender:',
                                            style: TextStyle(
                                                color: Color(NewDarkBlue),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                              '${widget.myPatientsInfo.gender}'),
                                          SizedBox(height: 30),
                                          Text(
                                            'Description:',
                                            style: TextStyle(
                                                color: Color(NewDarkBlue),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                              '${widget.myPatientsInfo.description}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: Text(
                        'Show more',
                        style: TextStyle(color: Color(newOrange), fontSize: 15),
                      ))
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              thickness: 1,
              color: Color(black),
            ),
          ),
        ],
      ),
    );
  }
}
