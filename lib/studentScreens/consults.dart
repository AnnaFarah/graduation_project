import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/patient/consulation.dart';
import 'package:newstart/studentScreens/transferPatient.dart';
import 'package:newstart/tryCalendar.dart';

import '../constant/appColor.dart';

class Consults extends StatefulWidget {
  final ConsulateInfo consulateInfo;
  const Consults({required this.consulateInfo, super.key});
  @override
  State<Consults> createState() => _ConsultsState();
}

class _ConsultsState extends State<Consults> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Type:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '${widget.consulateInfo.type}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          "Phone number:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '${widget.consulateInfo.phoneNumber}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    widget.consulateInfo.description == null
                        ? SizedBox()
                        : Row(
                            children: [
                              Text(
                                "Description:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                '${widget.consulateInfo.description}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Color(newOrange),
                                size: 25,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(CalendarStudent(
                                        id: widget.consulateInfo.patientID));
                                  },
                                  child: Text(
                                    'Add to Calendar',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ))
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(ScrollList(id: widget.consulateInfo.id));
                              },
                              child: Text(
                                "Transfer",
                                style: TextStyle(
                                    color: Color(newOrange),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
