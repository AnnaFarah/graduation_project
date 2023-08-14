import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/main.dart';
import 'package:newstart/patientScreens/patient_home_page.dart';

import '../component/getAndPost.dart';
import '../constant/appliApis.dart';
import '../patientClasses/patientAppointmentInformation.dart';

class MAkeAnAppointment extends StatefulWidget {
  @override
  State<MAkeAnAppointment> createState() => _MAkeAnAppointmentState();
}

class _MAkeAnAppointmentState extends State<MAkeAnAppointment> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  GetPost getPost = GetPost();

  bool isLoading = false;

  late PatientAppointmentInformation patientAppointmentInformation;

  _makeAppointment() async {
    isLoading = true;
    setState(() {});
    var response = await getPost.postRequest(consultApi, {
      'description': descriptionController.text,
      'phoneNumber': phoneNumberController.text
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${patientSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (response['message'] == "Consultation request added successfully") {
      print("appointment added");
      //patientSharedPreferences.setString('key', value)
      Get.off(PatientHomePage());
    } else {
      print('appointment error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(background2),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 300, top: 20),
            child: ElevatedButton(
              onPressed: () {
                Get.off(PatientHomePage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(newOrange),
              ),
              child: Icon(Icons.arrow_back),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100, top: 20),
            //Make an appointment
            child: Text('47'.tr,
                style: TextStyle(
                    fontFamily: 'cookie', color: Colors.black, fontSize: 35)),
          ),
          Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, top: 50),
                child: Column(
                  children: [
                    TextFormField(
                      controller: descriptionController,
                      validator: (val) {},
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.description_outlined,
                            color: Color(navyBlue),
                            size: 30,
                          ),
                          //description
                          hintText: "22".tr,
                          hintStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w300),
                          border: InputBorder.none),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      validator: (val) {},
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone_rounded,
                            color: Color(navyBlue),
                            size: 30,
                          ),
                          //phone number
                          hintText: "39".tr,
                          hintStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w300),
                          border: InputBorder.none),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              await _makeAppointment();
            },
            //confirm
            child: Text('19'.tr),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(newOrange),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 120)),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.off(PatientHomePage());
            },
            //Cancel
            child: Text('20'.tr),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(grey),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 120)),
          ),
        ],
      ),
    );
  }
}
