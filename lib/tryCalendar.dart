import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/studentScreens/consultationPatients.dart';

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
      Get.off(ConsultationPatients());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(newDarkBlue),
      body: Container(
          child: Column(children: [
        Expanded(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color(newDarkBlue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month_rounded),
              SizedBox(
                width: 8,
              ),
              Text(
                '41'.tr,
                style: TextStyle(
                    fontFamily: 'cookie', color: Colors.black, fontSize: 43),
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
                  color: Color(newLightBeige),
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
                            TextStyle(fontSize: 20, color: Color(newDarkBlue))),
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
                    Text('43'.tr,
                        style:
                            TextStyle(fontSize: 20, color: Color(newDarkBlue))),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('44'.tr),
                            Text(
                              ':  ${pickedHour} : ${pickedMin}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(navyBlue)),
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
                    SizedBox(
                      height: 80,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await calendarAPI();
                      },
                      child: Text('19'.tr),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Color(newOrange),
                          fixedSize: Size(250, 40)),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Get.off(ConsultationPatients());
                      },
                      child: Text('20'.tr),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.grey.shade400,
                          fixedSize: Size(250, 40)),
                    ),
                  ],
                ),
              ),
            )),
      ])),
    );
  }
}
