import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/student/patientRecords.dart';
import 'package:newstart/studentScreens/getPatients.dart';
import 'package:newstart/studentScreens/records.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class ShowRecord extends StatefulWidget {
  final int id;
  ShowRecord({required this.id});

  @override
  State<ShowRecord> createState() => _ShowRecordState();
}

class _ShowRecordState extends State<ShowRecord> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  GetPost getPost = GetPost();
  List listOfRecords = [];

  showRecords() async {
    isLoading = true;
    setState(() {});
    var responseBody =
        await getPost.getRequest('${url}/api/ShowPatientRecord/${widget.id}', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (responseBody['message'] == 'this is your patient record') {
      listOfRecords.add(responseBody['data']);
      print('list of record : ${listOfRecords}');
      print('flutter : success showing patient s record');
    } else {
      print('flutter: error showing record');
    }
  }

  @override
  void initState() {
    showRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 330, top: 30),
                      child: IconButton(
                        onPressed: () {
                          Get.off(GetPatients());
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Color(black),
                        iconSize: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 200, top: 10),
                      child: Text(
                        'Patient record',
                        style: TextStyle(
                            color: Color(newOrange),
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    listOfRecords.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 210),
                            child: Center(
                              child: Text('Empty',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.grey.shade700)),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount: listOfRecords.length,
                                itemBuilder: (context, i) {
                                  PatientRecordInfo patientRecordInfo =
                                      PatientRecordInfo(
                                          id: listOfRecords[i]['id'],
                                          patientID: listOfRecords[i]
                                              ['patient_id'],
                                          studentID: listOfRecords[i]
                                              ['student_id'],
                                          lastDisease: listOfRecords[i]
                                              ['last_disease_name'],
                                          currentDisease: listOfRecords[i]
                                              ['current_disease_name'],
                                          generalDisease: listOfRecords[i]
                                              ['general_description']);
                                  return Records(
                                      patientRecordInfo: patientRecordInfo);
                                }),
                          ),
                  ],
                ))));
  }
}

// class ShowMoreRecord extends StatefulWidget {
//   final PatientRecordInfo patientRecordInfo;
//   const ShowMoreRecord({required this.patientRecordInfo, super.key});
//   @override
//   State<ShowMoreRecord> createState() => _ShowMoreRecordState();
// }

// class _ShowMoreRecordState extends State<ShowMoreRecord> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 20, top: 20),
//           child: Container(
//             width: 310,
//             height: 150,
//             decoration: BoxDecoration(
//               color: Color(newBeige),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text('32'.tr),
//                               Text(
//                                 ': ${widget.patientRecordInfo.lastDisease}',
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text('33'.tr),
//                               Text(
//                                 ': ${widget.patientRecordInfo.currentDisease}',
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text('34'.tr),
//                               Text(
//                                 ': ${widget.patientRecordInfo.generalDisease}',
//                               ),
//                             ],
//                           ),
//                         ]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
