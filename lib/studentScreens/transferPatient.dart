import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/studentScreens/consultationPatients.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class ScrollList extends StatefulWidget {
  final int id;
  ScrollList({required this.id});

  @override
  State<ScrollList> createState() => _ScrollListState();
}

class _ScrollListState extends State<ScrollList> {
  var chosenID;
  bool isLoading = false;
  GetPost getPost = GetPost();
  var word;
  bool test = false;
  List second = [];
  List list = [];
  // _changeTest() {
  //   this.test = true;
  // }

  getSecondList() async {
    isLoading = true;
    setState(() {});
    var response = await getPost
        .getRequest('${url}/api/getClinicalConditionsByDepartment/${word}', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});
    if (response['message'] == "these all Clinical Conditions By department") {
      test = true;
      second.clear();
      print(response['data'][1]['clinical_condition']);
      second.addAll(response['data']);
      //print('Data: $second');
      for (int i = 0; i < second.length; i++) {
        list.add(second[i]['clinical_condition']);
      }
      print("list: ${list}");
    }
  }

  confirmTransfer() async {
    isLoading = true;
    setState(() {});
    print('consulation id : ${widget.id}');
    print('chosen id : ${chosenID}');
    var response =
        await getPost.postRequest('${url}/api/patientTransfer/${widget.id}', {
      'disease_name_id': chosenID.toString()
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(newDarkBlue),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(color: Color(newDarkBlue)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.off(ConsultationPatients());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(newOrange),
                            ),
                            child: Icon(Icons.arrow_back),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            '62'.tr,
                            style: TextStyle(
                                fontFamily: 'cookie',
                                color: Colors.black,
                                fontSize: 35),
                          ),
                        ],
                      ),
                    ),
                  ))),
          Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Color(newLightBeige),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        hint: Text('قسم طب الفم'),
                        items: [
                          'قسم طب الفم',
                          'قسم المداواة',
                          'قسم جراحة الوجه والفكين',
                          'قسم التعويضات المتحركة',
                          'قسم علم نسج حول سنية',
                          'قسم التقويم',
                          'قسم التعويضات الثابتة',
                          'قسم طب أسنان الأطفال'
                        ]
                            .map((e) =>
                                DropdownMenuItem(child: Text('$e'), value: e))
                            .toList(),
                        onChanged: (val) async {
                          setState(() {
                            word = val.toString();
                          });
                          await getSecondList();
                        },
                        value: word,
                      ),
                      test == false
                          ? SizedBox()
                          : Flexible(
                              child: ListView.builder(
                                  itemCount: second.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) =>
                                      // Text('${second[i]['clinical_condition']}'),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              chosenID = second[i]['id'];
                                            });
                                          },
                                          child: Text(
                                            '${second[i]['clinical_condition']}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )))),
                      test == false
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await confirmTransfer();
                                  },
                                  child: Text('19'.tr),
                                  style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      backgroundColor: Color(newOrange),
                                      fixedSize: Size(250, 40))),
                            )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
