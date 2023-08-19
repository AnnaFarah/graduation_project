import 'package:flutter/material.dart';
import 'package:newstart/student/patientRecords.dart';

import '../constant/appColor.dart';

class Records extends StatefulWidget {
  final PatientRecordInfo patientRecordInfo;
  const Records({required this.patientRecordInfo, super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Row(children: [
            Text('Current disease:',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 18)),
            SizedBox(
              width: 30,
            ),
            Text(
              '${widget.patientRecordInfo.currentDisease}',
              style: TextStyle(fontSize: 17),
            )
          ]),
          SizedBox(
            height: 15,
          ),
          Row(children: [
            Text('Last disease:',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 18)),
            SizedBox(
              width: 30,
            ),
            Text(
              '${widget.patientRecordInfo.lastDisease}',
              style: TextStyle(fontSize: 17),
            )
          ]),
          SizedBox(
            height: 15,
          ),
          Row(children: [
            Text('General description:',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 18)),
            SizedBox(
              width: 30,
            ),
            Text(
              '${widget.patientRecordInfo.generalDisease}',
              style: TextStyle(fontSize: 17),
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Divider(
              thickness: 1,
              color: Color(black),
            ),
          ),
        ],
      ),
    );
  }
}
