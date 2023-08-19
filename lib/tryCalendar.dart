import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/constant/appColor.dart';

import 'component/getAndPost.dart';
import 'constant/appliApis.dart';
import 'main.dart';

class CalendarStudent extends StatefulWidget {
  final int id;
  CalendarStudent({required this.id});

  @override
  State<CalendarStudent> createState() => _CalendarStudentState();
}

class _CalendarStudentState extends State<CalendarStudent> {
  DateTime selectedDate = DateTime.now();
  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  TimeOfDay pickedTime = TimeOfDay.now();
  late int pickedHour = TimeOfDay.now().hour;
  late int pickedMin = TimeOfDay.now().minute;
  late String selectedDayName;
  bool isLoading = false;
  GetPost getPost = GetPost();
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        pickedTime = value!;
        pickedHour = value.hour;
        pickedMin = value.minute;
        print(pickedTime);
      });
    });
  }

  calendarAPI() async {
    isLoading = true;
    setState(() {});
    print('patientID : ${widget.id}');
    var response = await getPost
        .postRequest('${url}/api/addCalender/${widget.id}.toString()', {
      'date': selectedDate.toString(),
      'time': pickedTime.toString(),
      'day': selectedDayName
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});
    if (response['message'] == 'added calender successfully') {
      print('patient_id: ${widget.id}');
      print('Flutter: added to calendar');
      print('response body: ${response}');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Added to calendar",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error! something went wrong.",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(NewDarkBlue),
      body: Container(
          child: Column(children: [
        Expanded(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color(NewDarkBlue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon(Icons.calendar_month_rounded),
              SizedBox(
                width: 8,
              ),
              Text(
                '41'.tr,
                style: TextStyle(color: Color(white), fontSize: 30),
              )
            ],
          ),
        )),
        Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Color(white),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    Text('42'.tr,
                        style:
                            TextStyle(fontSize: 20, color: Color(NewDarkBlue))),
                    SizedBox(
                      height: 30,
                    ),
                    DatePicker(
                      DateTime.now(),
                      height: 100,
                      width: 80,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Color(newBeige),
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        setState(() {
                          selectedDate = date;
                          selectedDay = date.day;
                          selectedMonth = date.month;
                          selectedYear = date.year;
                          print(selectedDate);
                          print(selectedDay);
                          print(selectedMonth);
                          print(selectedYear);
                          if (selectedDate.weekday == 1) {
                            selectedDayName = 'Monday';
                          } else if (selectedDate.weekday == 2) {
                            selectedDayName = 'Tuesday';
                          } else if (selectedDate.weekday == 3) {
                            selectedDayName = 'Wednesday';
                          } else if (selectedDate.weekday == 4) {
                            selectedDayName = 'Thursday';
                          } else if (selectedDate.weekday == 5) {
                            selectedDayName = 'Friday';
                          } else if (selectedDate.weekday == 6) {
                            selectedDayName = 'Saturday';
                          } else if (selectedDate.weekday == 7) {
                            selectedDayName = 'Sunday';
                          }
                          print(selectedDayName);
                        });
                      },
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: Row(
                        children: [
                          Text('43'.tr,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Color(NewDarkBlue),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(width: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    ' ${pickedHour} : ${pickedMin}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color(navyBlue)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              _showTimePicker();
                            },
                            icon: Icon(Icons.edit),
                            color: Color(navyBlue),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await calendarAPI();
                        },
                        child: isLoading == true
                            ? CircularProgressIndicator(
                                color: Color(white),
                              )
                            : Text(
                                'Confirm',
                                style: TextStyle(
                                    color: Color(white), fontSize: 19),
                              ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            backgroundColor: Color(newOrange),
                            fixedSize: Size(250, 50)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: isLoading == true
                            ? CircularProgressIndicator(
                                color: Color(white),
                              )
                            : Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Color(white), fontSize: 19),
                              ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            backgroundColor: Colors.grey.shade400,
                            fixedSize: Size(250, 50)),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ])),
    );
  }
}
