import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

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
                '29'.tr,
                style: TextStyle(fontSize: 20, color: Color(newDarkBlue)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  controller: lastDiseaseName,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.description_outlined,
                        color: Color(newBeige),
                        size: 30,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      hintText: "32".tr,
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  controller: currentDiseaseName,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.description_outlined,
                        color: Color(newBeige),
                        size: 30,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      hintText: "33".tr,
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  controller: generalDescription,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Color(newBeige),
                        size: 30,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      hintText: "34".tr,
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    await getRecord();
                  },
                  child: Text('19'.tr),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(newOrange),
                      fixedSize: Size(120, 16)),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('Cancel'),
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.grey, fixedSize: Size(120, 16)),
              // )
            ],
          )),
    );
  }
}
