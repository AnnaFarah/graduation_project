import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/lab/timeInfo.dart';
import 'package:newstart/studentScreens/student_home_page.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';
import '../store/getProducts.dart';
import '../studentScreens/studentShowCalendar.dart';

class GetAvailableTime extends StatefulWidget {
  @override
  State<GetAvailableTime> createState() => _GetAvailableTimeState();
}

class _GetAvailableTimeState extends State<GetAvailableTime> {
  GlobalKey<FormState> formKey = GlobalKey();

  int currentIndex = 3;

  List availableTime = [];

  bool isLoading = false;

  GetPost getPost = GetPost();

  getTime() async {
    isLoading = true;
    setState(() {});

    var responseBody =
        await getPost.getRequest('${url}/api/ViewAvailableAppointments', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (responseBody['message'] == "These are the Available Appointments") {
      availableTime.addAll(responseBody['data']);
      print('available time : ${availableTime}');
      print('Flutter: got your available time');
    } else {
      print('flutter: error getting times');
    }
  }

  @override
  void initState() {
    getTime();
    super.initState();
  }

  Future<void> register(int id, String patient) async {
    isLoading = true;
    setState(() {});

    var responseBody =
        await getPost.postRequest('${url}/api/bookAppointment/${id}', {
      'patientName': patient
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: availableTime.isEmpty
          ? Text('No time'.toUpperCase())
          : Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(newLightBeige), Color(newDustyBlue)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: Column(children: [
                    Center(
                      child: Text('Lab',
                          style: TextStyle(
                              fontFamily: 'cookie',
                              color: Colors.black,
                              fontSize: 45)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        color: Colors.grey.shade500,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: availableTime.length,
                            itemBuilder: (context, i) {
                              TimeInfo timeInfo = TimeInfo(
                                  id: availableTime[i]['id'],
                                  date: availableTime[i]['date'],
                                  start: availableTime[i]['start_time'],
                                  end: availableTime[i]['end_time']);
                              return ShowTime(
                                  timeInfo: timeInfo, register: register);
                            }))
                  ]),
                ),
              )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedLabelStyle: TextStyle(color: Color(darkBlue)),
        onTap: (value) {
          setState(() {
            currentIndex = value;
            if (currentIndex == 0) {
              Get.off(HomePageS());
            } else if (currentIndex == 1) {
              Get.to(ShowStudentCalendar());
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
              'icons/teeth-open.png',
              height: 25,
            ),
            label: 'X-ray',
          ),
        ],
      ),
    );
  }
}

class ShowTime extends StatefulWidget {
  final TimeInfo timeInfo;
  final Future<void> Function(int, String) register;
  const ShowTime({required this.timeInfo, required this.register, super.key});
  @override
  State<ShowTime> createState() => _ShowTimeState();
}

class _ShowTimeState extends State<ShowTime> {
  TextEditingController patientName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${widget.timeInfo.date}'),
            Text('${widget.timeInfo.start}'),
            Text('${widget.timeInfo.end}')
          ],
        ),
        TextButton(
            onPressed: () {
              //await widget.register(widget.timeInfo.id);
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              Text('Add patient name:'),
                              TextFormField(
                                controller: patientName,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.date_range_outlined,
                                      color: Color(navyBlue),
                                      size: 30,
                                    ),
                                    hintText: "Patient name",
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300),
                                    border: InputBorder.none),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await widget.register(
                                        widget.timeInfo.id, patientName.text);
                                  },
                                  child: Text('confirm'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(newOrange),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 90)),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            },
            child: Text('register'))
      ],
    );
  }
}
