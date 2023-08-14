import 'package:flutter/widgets.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/student/requestInfo.dart';

class ShowStudentPreRequests extends StatefulWidget {
  final RequestInfo requestInfo;
  const ShowStudentPreRequests({required this.requestInfo, super.key});

  @override
  State<ShowStudentPreRequests> createState() => _ShowStudentPreRequestsState();
}

class _ShowStudentPreRequestsState extends State<ShowStudentPreRequests> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Priority:',
              style: TextStyle(
                  color: Color(NewDarkBlue),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text('${widget.requestInfo.priority}')
          ],
        ),
        Row(
          children: [
            Text(
              'Specialization:',
              style: TextStyle(
                  color: Color(NewDarkBlue),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text('${widget.requestInfo.specialization}')
          ],
        ),
        Row(
          children: [
            Text(
              'Year:',
              style: TextStyle(
                  color: Color(NewDarkBlue),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text('${widget.requestInfo.year}')
          ],
        )
      ],
    );
  }
}
