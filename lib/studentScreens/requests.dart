import 'package:flutter/material.dart';
import 'package:newstart/student/requestInfo.dart';

import '../constant/appColor.dart';

class StudentRequests extends StatefulWidget {
  final RequestInfo requestInfo;
  const StudentRequests({required this.requestInfo, super.key});
  @override
  State<StudentRequests> createState() => _StudentRequestsState();
}

class _StudentRequestsState extends State<StudentRequests> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Priority',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                '${widget.requestInfo.priority}',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Specialization',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
              SizedBox(
                width: 30,
              ),
              Text('${widget.requestInfo.specialization}',
                  style: TextStyle(fontSize: 18))
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Year',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
              SizedBox(
                width: 30,
              ),
              Text('${widget.requestInfo.year}', style: TextStyle(fontSize: 18))
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 20, top: 5),
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
