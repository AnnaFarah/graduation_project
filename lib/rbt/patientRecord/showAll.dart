import 'package:flutter/material.dart';

class ShowPatientRecord extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  var lastDiseaseName = 'last';
  var currentDiseaseName = 'current';
  var generalDescription = 'general';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 500,
                  height: 100,
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Text(lastDiseaseName),
                      SizedBox(height: 2),
                      Text(currentDiseaseName),
                      SizedBox(height: 2),
                      Text(generalDescription),
                      SizedBox(height: 2),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
