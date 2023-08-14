import 'package:flutter/material.dart';
import 'package:newstart/component/getAndPost.dart';

import '../../main.dart';

class CreatePatientRecord extends StatefulWidget {
  @override
  State<CreatePatientRecord> createState() => _CreatePatientRecordState();
}

class _CreatePatientRecordState extends State<CreatePatientRecord> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController lastDiseaseName = TextEditingController();

  TextEditingController currentDiseaseName = TextEditingController();

  TextEditingController generalDescription = TextEditingController();

  GetPost getPost = GetPost();
  bool isLoading = false;

  sendCreate() async {
    isLoading = true;
    setState(() {});
    var response = await getPost
        .postRequest('http://10.0.2.2:8000/api/CreatePatientRecord/2', {
      'last_disease_name': lastDiseaseName.text,
      'current_disease_name': currentDiseaseName.text,
      'general_description': generalDescription.text
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: false,
                controller: lastDiseaseName,
                // validator: (val) {
                //   return validator(val!, 3, 40);
                // },
                decoration: InputDecoration(
                    // icon: Icon(
                    //   Icons.task_alt_outlined,
                    //   color: Color(navyBlue),
                    //   size: 30,
                    // ),
                    hintText: "Last disease name",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w300),
                    border: InputBorder.none),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: false,
                controller: currentDiseaseName,
                // validator: (val) {
                //   return validator(val!, 3, 40);
                // },
                decoration: InputDecoration(
                    // icon: Icon(
                    //   Icons.task_alt_outlined,
                    //   color: Color(navyBlue),
                    //   size: 30,
                    // ),
                    hintText: "current disease name",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w300),
                    border: InputBorder.none),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: false,
                controller: generalDescription,
                // validator: (val) {
                //   return validator(val!, 3, 40);
                // },
                decoration: InputDecoration(
                    // icon: Icon(
                    //   Icons.task_alt_outlined,
                    //   color: Color(navyBlue),
                    //   size: 30,
                    // ),
                    hintText: "general description",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w300),
                    border: InputBorder.none),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    await sendCreate();
                  },
                  child: Text('confirm'))
            ],
          )),
    );
  }
}
