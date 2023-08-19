import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/homePageForPatients.dart';
import 'package:newstart/main.dart';

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

  makeAppointment() async {
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
      Get.off(HomePageForPatients());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Done",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      print('appointment error');
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
      backgroundColor: Color(white),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 300),
                child: IconButton(
                    onPressed: () {
                      Get.off(HomePageForPatients());
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 20),
                child: Text(
                  'Make an appointment',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 220, top: 70),
                child: Text(
                  'Description:',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                height: 50,
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "description",
                    //enabledBorder: OutlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 220, top: 40),
                child: Text(
                  'Phone number:',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                height: 50,
                child: TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "+963 9........",
                    //enabledBorder: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await makeAppointment();
                  },
                  child: isLoading == true
                      ? CircularProgressIndicator(
                          color: Color(white),
                        )
                      : Text(
                          'Confirm',
                          style: TextStyle(color: Color(white), fontSize: 19),
                        ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      backgroundColor: Color(newOrange),
                      fixedSize: Size(250, 50)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
