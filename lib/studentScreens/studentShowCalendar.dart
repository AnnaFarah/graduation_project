import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/store/getProducts.dart';
import 'package:newstart/studentScreens/calendars.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';
import '../student/calendarInfo.dart';

class ShowStudentCalendar extends StatefulWidget {
  @override
  State<ShowStudentCalendar> createState() => _ShowStudentCalendarState();
}

class _ShowStudentCalendarState extends State<ShowStudentCalendar> {
  GlobalKey<FormState> formKey = GlobalKey();

  List posts = [];

  int currentIndex = 1;

  bool isLoading = false;

  GetPost getPost = GetPost();

  Future<void> getAppointmentsOnCalendar() async {
    isLoading = true;
    setState(() {});
    var responseBody = await getPost.getRequest(showAllCalendar, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});
    if (responseBody['message'] == "These are your calenders") {
      print(responseBody['data'][0]);
      posts.addAll(responseBody['data']);

      //print("posts: ${posts}");
      print('Flutter: success fetching from calendar');
    } else {
      print('flutter: error fetching from calendar');
    }
  }

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

    if (response['message'] == 'your calendar has been deleted successfully') {
      print('flutter: success deleting from calendar');
      posts.clear();
      getAppointmentsOnCalendar();
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
  void initState() {
    getAppointmentsOnCalendar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(white),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'My calendar',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w500),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              posts.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 210),
                      child: Center(
                        child: Text('Empty',
                            style: TextStyle(
                                fontSize: 25, color: Colors.grey.shade700)),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, i) {
                            Calendar calendar = Calendar(
                                id: posts[i]['id'],
                                date: posts[i]['date'],
                                time: posts[i]['time'],
                                type: posts[i]['type'],
                                day: posts[i]['day'],
                                patientID: posts[i]['patient_id'],
                                studentID: posts[i]['student_id']);
                            return Calendars(
                              calendar: calendar,
                              posts: posts,
                              getAppointmentsOnCalendar:
                                  getAppointmentsOnCalendar,
                            );
                          }),
                    ),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedLabelStyle: TextStyle(color: Color(darkBlue)),
        onTap: (value) {
          setState(() {
            currentIndex = value;
            if (currentIndex == 0) {
              Get.off(HomePageForStudents());
            } else if (currentIndex == 1) {
              Get.off(ShowStudentCalendar());
            } else if (currentIndex == 2) {
              Get.off(GetStoreProducts());
            } else if (currentIndex == 3) {}
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'icons/home.png',
                height: 25,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'icons/calendar.png',
                height: 25,
              ),
              label: 'calendar'),
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/shopping-cart-add.png',
              height: 25,
            ),

            // Image.asset('icons/shopping-cart-add.png'),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/teeth-open1.png',
              height: 25,
            ),
            label: 'X-ray',
          ),
        ],
      ),
    );
  }
}

class EditCalendarItem extends StatefulWidget {
  final Calendar calendar;
  final Future<void> Function(int) deleteFromCalendar;
  const EditCalendarItem(
      {required this.calendar, required this.deleteFromCalendar, super.key});

  @override
  State<EditCalendarItem> createState() => _EditCalendarItemState();
}

class _EditCalendarItemState extends State<EditCalendarItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text('${widget.calendar.day}'),
                VerticalDivider(
                  color: Color(green),
                  thickness: 2,
                ),
                Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Color(grey),
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('${widget.calendar.date}'),
                            Text('${widget.calendar.time}')
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              await widget
                                  .deleteFromCalendar(widget.calendar.id);
                            },
                            icon: Icon(Icons.delete_forever_outlined))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
