import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/homePageForPatients.dart';
import 'package:newstart/patientClasses/madicalInfo.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class MedicalProfile extends StatefulWidget {
  @override
  State<MedicalProfile> createState() => _MedicalProfileState();
}

class _MedicalProfileState extends State<MedicalProfile> {
  bool isLoading = false;

  GetPost getPost = GetPost();

  List medical = [];

  getMedicals() async {
    isLoading = true;
    setState(() {});

    var responseBody = await getPost.getRequest('${url}/api/myPrescriptions', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${patientSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (responseBody['message'] == "these are All your Prescriptions") {
      medical.addAll(responseBody['data']);
      print('flutter: done showing medical profile');
      print('medicals : ${medical}');
    } else {
      print('flutter: error showing medical ');
    }
  }

  @override
  void initState() {
    getMedicals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.only(right: 330, top: 30),
        child: IconButton(
          onPressed: () {
            Get.off(HomePageForPatients());
          },
          icon: Icon(Icons.arrow_back),
          color: Color(black),
          iconSize: 35,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 150, top: 10),
        child: Text(
          'My medical profile:',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.w400),
        ),
      ),
      medical.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 210),
              child: Center(
                child: Text('Empty',
                    style:
                        TextStyle(fontSize: 25, color: Colors.grey.shade700)),
              ),
            )
          : Expanded(
              child: ListView.builder(
                  itemCount: medical.length,
                  itemBuilder: (context, i) {
                    MedicalInfo medicalInfo = MedicalInfo(
                        id: medical[i]['id'],
                        diseaseName: medical[i]['disease_name'],
                        start: medical[i]['starting_date'],
                        end: medical[i]['end_date'],
                        patientID: medical[i]['patient_id'],
                        studentID: medical[i]['student_id'],
                        description: medical[i]['description']);
                    return ShowMediacl(medicalInfo: medicalInfo);
                  }),
            ),
    ]));
  }
}

class ShowMediacl extends StatefulWidget {
  final MedicalInfo medicalInfo;
  const ShowMediacl({required this.medicalInfo, super.key});
  @override
  State<ShowMediacl> createState() => _ShowMediaclState();
}

class _ShowMediaclState extends State<ShowMediacl> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 310,
            height: 100,
            decoration: BoxDecoration(
              color: Color(newBeige),
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                children: [
                  //Disease name
                  Text('36'.tr),
                  Text(': ${widget.medicalInfo.diseaseName}'),
                ],
              ),
              Row(
                children: [
                  //Started at
                  Text('16'.tr),
                  Text(': ${widget.medicalInfo.start}'),
                ],
              ),
              Row(
                children: [
                  //Ended at
                  Text('17'.tr),
                  Text(': ${widget.medicalInfo.end}'),
                ],
              ),
              widget.medicalInfo.description == null
                  ? SizedBox()
                  : Row(
                      children: [
                        //Description
                        Text('15'.tr),
                        Text(': ${widget.medicalInfo.description}'),
                      ],
                    )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.grey.shade500,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
