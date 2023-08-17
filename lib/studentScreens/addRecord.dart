import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';
import 'getPatients.dart';

class AddRecord extends StatefulWidget {
  int id;
  AddRecord({required this.id});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  bool isLoading = false;

  GetPost getPost = GetPost();

  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController lastDiseaseName = TextEditingController();

  final TextEditingController currentDiseaseName = TextEditingController();

  final TextEditingController generalDescription = TextEditingController();

  getRecord() async {
    isLoading = true;
    setState(() {});
    print('lastDiseaseName : ${lastDiseaseName.text}');
    print('currentDiseaseName : ${currentDiseaseName.text}');
    print('generalDescription : ${generalDescription.text}');
    var responseBody = await getPost
        .postRequest('${url}/api/CreatePatientRecord/${widget.id}', {
      'last_disease_name': lastDiseaseName.text,
      'current_disease_name': currentDiseaseName.text,
      'general_description': generalDescription.text
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (responseBody['message'] == "added your patient record successfully") {
      print("flutter: added record");
      Get.off(GetPatients());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Record added successfully",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      print('flutter: error adding prescription');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "error!! Something went wrong",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: formKey,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(white),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 350),
                    child: IconButton(
                        onPressed: () {
                          Get.off(GetPatients());
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: Text(
                      'Add record:',
                      style: TextStyle(
                          color: Color(newOrange),
                          fontSize: 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 220, top: 50),
                    child: Text(
                      'Last disease:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: TextFormField(
                      controller: lastDiseaseName,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "last disease",
                        //enabledBorder: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 220, top: 50),
                    child: Text(
                      'Current disease:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: TextFormField(
                      controller: currentDiseaseName,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "current disease",
                        //enabledBorder: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 190, top: 50),
                    child: Text(
                      'General description:',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: TextFormField(
                      controller: generalDescription,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "general description",
                        //enabledBorder: OutlineInputBorder()
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await getRecord();
                      },
                      child: isLoading == true
                          ? CircularProgressIndicator(
                              color: Color(white),
                            )
                          : Text(
                              'Add',
                              style:
                                  TextStyle(color: Color(white), fontSize: 19),
                            ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          backgroundColor: Color(NewDarkBlue),
                          fixedSize: Size(220, 50)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
