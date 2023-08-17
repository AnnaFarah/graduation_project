import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/studentScreens/getPatients.dart';

import '../constant/appliApis.dart';
import '../main.dart';

class AddPrescription1 extends StatefulWidget {
  int id;
  AddPrescription1({required this.id});

  @override
  State<AddPrescription1> createState() => _AddPrescription1State();
}

class _AddPrescription1State extends State<AddPrescription1> {
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController diseaseName = TextEditingController();

  final TextEditingController description = TextEditingController();

  final TextEditingController startDate = TextEditingController();

  final TextEditingController endDate = TextEditingController();

  bool isLoading = false;

  GetPost getPost = GetPost();

  Future<void> addPrescription() async {
    isLoading = true;
    setState(() {});
    print('disease name : ${diseaseName.text}');
    print('diseaseName  : ${diseaseName.text}');
    print('starting_date : ${startDate.text}');
    var response =
        await getPost.postRequest('${url}/api/AddPrescription/${widget.id}', {
      'disease_name': diseaseName.text,
      'description': description.text,
      'starting_date': startDate.text,
      'end_date': endDate.text,
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;
    setState(() {});

    if (response['message'] ==
        "your prescription has been added successfully ") {
      print("flutter: added prescription");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Added successfully",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      print('flutter: error adding prescription');
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
                      'Add prescription:',
                      style: TextStyle(
                          color: Color(newOrange),
                          fontSize: 28,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 220, top: 50),
                    child: Text(
                      'Disease name:',
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
                      controller: diseaseName,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "name",
                        //enabledBorder: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 220, top: 50),
                    child: Text(
                      'Description:',
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
                      controller: description,
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
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Start date:',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 150,
                                height: 50,
                                child: TextFormField(
                                  controller: startDate,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    hintText: "Start date",
                                    //enabledBorder: OutlineInputBorder()
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'End date:',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 150,
                                height: 50,
                                child: TextFormField(
                                  controller: endDate,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    hintText: "end date",
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ),
                  SizedBox(height: 60),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await addPrescription();
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
