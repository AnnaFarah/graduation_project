import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';

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
    } else {
      print('flutter: error adding prescription');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Text(
                '35'.tr,
                style: TextStyle(fontSize: 20, color: Color(newDarkBlue)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  controller: diseaseName,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.description_outlined,
                        color: Color(newBeige),
                        size: 30,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      hintText: "36".tr,
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.description_outlined,
                        color: Color(newBeige),
                        size: 30,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      hintText: "22".tr,
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  controller: startDate,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Color(newBeige),
                        size: 30,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      hintText: "23".tr,
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  controller: endDate,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Color(newBeige),
                        size: 30,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      hintText: "24".tr,
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    await addPrescription();
                  },
                  child: Text('19'.tr),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(newOrange),
                      fixedSize: Size(120, 16)),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('20'.tr),
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.grey, fixedSize: Size(120, 16)),
              // )
            ],
          )),
    );
  }
}
