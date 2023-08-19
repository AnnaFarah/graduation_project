import 'package:flutter/material.dart';
import 'package:newstart/student/calendarInfo.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class Calendars extends StatefulWidget {
  final Calendar calendar;
  final List posts;
  final Future<void> Function() getAppointmentsOnCalendar;
  const Calendars(
      {required this.calendar,
      required this.posts,
      required this.getAppointmentsOnCalendar,
      super.key});

  @override
  State<Calendars> createState() => _CalendarsState();
}

class _CalendarsState extends State<Calendars> {
  bool isLoading = false;

  GetPost getPost = GetPost();

  Future<void> deleteFromCalendar(int id) async {
    isLoading = true;
    setState(() {});
    var response =
        await getPost.deleteRequest('${url}/api/DeleteFromCalendar/${id}', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response['message'] == 'your calendar has been deleted successfully ') {
      print('flutter: success deleting from calendar');

      widget.posts.clear();
      widget.getAppointmentsOnCalendar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Deleted successfully",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      print('flutter: error deleting from calendar');
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
            child: Row(children: [
              Container(
                  width: 80,
                  height: 90,
                  decoration: BoxDecoration(
                      color: Color(NewLightBlue),
                      borderRadius: BorderRadius.circular(10)),
                  child: widget.calendar.day == "Monday"
                      ? Center(
                          child: Text(
                          'Mon',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ))
                      : widget.calendar.day == "Tuesday"
                          ? Center(
                              child: Text('Tue',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20)))
                          : widget.calendar.day == "Wednesday"
                              ? Center(
                                  child: Text('Wed',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20)))
                              : widget.calendar.day == "Thursday"
                                  ? Center(
                                      child: Text('Thu',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20)))
                                  : widget.calendar.day == "Friday"
                                      ? Center(
                                          child: Text('Fri',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20)))
                                      : widget.calendar.day == "Saturday"
                                          ? Center(
                                              child: Text('Sat',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 20)))
                                          : widget.calendar.day == "Sunday"
                                              ? Center(
                                                  child: Text('Sun',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 20)))
                                              : SizedBox()),
              SizedBox(
                width: 10,
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18)),
                  SizedBox(height: 10),
                  Text('${widget.calendar.date}'),
                  SizedBox(height: 20),
                  Text("Time:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18)),
                  SizedBox(height: 10),
                  Text('${widget.calendar.time}')
                ],
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      await deleteFromCalendar(
                                          widget.calendar.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: Color(newOrange),
                                          fontSize: 18),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18),
                                    )),
                              ],
                              content: Text(
                                'Are you sure you want to delete?',
                                style: TextStyle(color: Colors.black),
                              )));
                  //await widget.deleteFromCalendar(widget.calendar.id);
                },
                icon: Icon(
                  Icons.delete_outlined,
                  size: 30,
                ),
                color: Color(newOrange),
              )
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            thickness: 1,
            color: Color(black),
          ),
        ),
      ],
    );
  }
}
