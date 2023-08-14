import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/constant/appliApis.dart';
import 'package:newstart/studentScreens/showPersoonalWork.dart';

import '../main.dart';

class AddPersonalWork extends StatefulWidget {
  @override
  State<AddPersonalWork> createState() => _AddPersonalWorkState();
}

class _AddPersonalWorkState extends State<AddPersonalWork> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  GlobalKey formState = GlobalKey();
  late File file;
  bool isLoading = false;
  GetPost getPost = GetPost();

  Future pickerCamera() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(myfile!.path);
    });
  }

  addWork() async {
    if (file == null) return;
    String path = file.path;
    print(path);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${url}/api/AddToMyPersonalWorks'));
    request.fields.addAll({
      'name': nameController.text,
      'description': descriptionController.text,
      'subject_name': subjectController.text
    });
    request.files.add(await http.MultipartFile.fromPath('photo', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(white),
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.off(StudentPersonalWork());
                    },
                    icon: Icon(Icons.arrow_back)),
                Text(
                  "55".tr,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: '25'.tr,
                labelStyle: TextStyle(color: Color(black), fontSize: 20),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(black)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: '15'.tr,
                labelStyle: TextStyle(color: Color(black), fontSize: 20),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(black)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: '56'.tr,
                labelStyle: TextStyle(color: Color(black), fontSize: 20),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(black)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      pickerCamera();
                    },
                    icon: Icon(Icons.camera_enhance_sharp)),
                Text('57'.tr)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await addWork();
                },
                child: Text(
                  '19'.tr,
                  style: TextStyle(fontSize: 15, color: Color(black)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(newOrange),
                    fixedSize: Size(200, 50)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
