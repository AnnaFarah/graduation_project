import 'package:flutter/material.dart';

import '../constant/appColor.dart';
import '../patientClasses/patientAppointmentFromData.dart';

class AppointmentDetails extends StatefulWidget {
  final PatientAppointmentFromData patientAppointmentFromData;
  const AppointmentDetails(
      {required this.patientAppointmentFromData, super.key});
  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Type',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(
                width: 30,
              ),
              Text('${widget.patientAppointmentFromData.type}')
            ],
          ),
          widget.patientAppointmentFromData.day == null
              ? Row(
                  children: [
                    Text(
                      'Day',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text('waiting..')
                  ],
                )
              : Row(
                  children: [
                    Text(
                      'Day',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text('${widget.patientAppointmentFromData.day}')
                  ],
                ),
          widget.patientAppointmentFromData.date == null
              ? Row(
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text('waiting..')
                  ],
                )
              : Row(
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text('${widget.patientAppointmentFromData.date}')
                  ],
                ),
          widget.patientAppointmentFromData.date == null
              ? Row(
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text('waiting..')
                  ],
                )
              : Row(
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text('${widget.patientAppointmentFromData.time}')
                  ],
                ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
