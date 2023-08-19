import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:newstart/studentScreens/studentLoginScreen.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';

class StudentSignup extends StatefulWidget {
  @override
  State<StudentSignup> createState() => _StudentSignupState();
}

class _StudentSignupState extends State<StudentSignup> {
  late File _file;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var type = 'Bachelor_Degree';
  var year = 'first';
  var specializations = 'لبية';

  Future pickerCamera() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _file = File(myfile!.path);
    });
  }

  post() async {
    if (_file == null) return;
    isLoading = true;
    setState(() {});
    String path = _file.path;

    print('name : ${name.text}');
    print('email : ${email.text}');
    print('password : ${password.text}');
    print('type : ${type}');
    print('year : ${year}');
    print('specialazation : ${specializations}');
    print('pic: ${path}');

    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest('POST', Uri.parse(studentRegister));
    request.fields.addAll({
      'name': name.text,
      'email': email.text,
      'password': password.text,
      'type': type,
      'year': year,
      'specializations': specializations
    });
    request.files
        .add(await http.MultipartFile.fromPath('university_card', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // var responseBody = await http.Response.fromStream(response);
    // var result = jsonDecode(responseBody.body);
    isLoading = false;
    setState(() {});
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.off(StudentLoginScreen());
      // sharedPreferences.setString('token', result['data']['token']);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/newBackground.JPG"), fit: BoxFit.cover),
        ),
        child: Column(children: [
          Form(
            key: formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(right: 220, top: 70),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 260, top: 40),
              //   child: Text(
              //     'Username:',
              //     style: TextStyle(color: Colors.black, fontSize: 20),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      hintText: "name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 260, top: 40),
              //   child: Text(
              //     'Email:',
              //     style: TextStyle(color: Colors.black, fontSize: 20),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 260, top: 40),
              //   child: Text(
              //     'Password:',
              //     style: TextStyle(color: Colors.black, fontSize: 20),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          pickerCamera();
                        },
                        color: Colors.black,
                        icon: Icon(Icons.camera_enhance_sharp)),
                    Text(
                      'Add your college picture id',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                    hint: Text('type'),
                    items: ['Bachelor_Degree', 'Master_Degree']
                        .map((e) =>
                            DropdownMenuItem(child: Text('$e'), value: e))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        type = val!;
                      });
                    },
                    value: type,
                  ),
                  DropdownButton(
                    hint: Text('year'),
                    items: ['first', 'second', 'third', 'fourth', 'fifth']
                        .map((e) =>
                            DropdownMenuItem(child: Text('$e'), value: e))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        year = val!;
                      });
                    },
                    value: year,
                  ),
                ],
              ),
              year == 'first' || year == 'second' || year == 'third'
                  ? DropdownButton(
                      hint: Text('specializations'),
                      items: [
                        'جراحة',
                        'طب أسنان الأطفال',
                        'أمراض الفم',
                        'تقويم',
                        'لثة',
                        'تعويضات المتحركة',
                        'تعويضات الثابتة',
                        'تجميل',
                        'لبية'
                      ]
                          .map((e) =>
                              DropdownMenuItem(child: Text('$e'), value: e))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          specializations = val!;
                        });
                      },
                      value: specializations,
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    await post()();
                  },
                  child: isLoading == true
                      ? CircularProgressIndicator(
                          color: Color(white),
                        )
                      : Text(
                          'Sign up',
                          style: TextStyle(color: Color(white), fontSize: 17),
                        ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      backgroundColor: Color(NewDarkBlue),
                      fixedSize: Size(220, 50)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(StudentLoginScreen());
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Color(newOrange), fontSize: 20),
                  ))
            ]),
          )
        ]),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     body: isLoading == true
  //         ? Center(child: CircularProgressIndicator())
  //         : Container(
  //             width: double.infinity,
  //             height: double.infinity,
  //             decoration: BoxDecoration(
  //                 gradient: LinearGradient(colors: [
  //               Color(faintBlue),
  //               Color(faintGreen),
  //             ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
  //             child: ListView(
  //               children: [
  //                 Form(
  //                   key: formKey,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             IconButton(
  //                               onPressed: () {
  //                                 Get.off(StudentLoginScreen());
  //                               },
  //                               icon: Icon(Icons.arrow_back),
  //                               color: Color(navyBlue),
  //                               iconSize: 30,
  //                             ),
  //                             Center(
  //                               child: Text(
  //                                 'Create new account',
  //                                 style: TextStyle(
  //                                     fontFamily: 'cookie',
  //                                     fontSize: 45,
  //                                     color: Color(navyBlue)),
  //                               ),
  //                             ),
  //                             Container(
  //                               margin: EdgeInsets.symmetric(vertical: 50),
  //                               padding: EdgeInsets.symmetric(horizontal: 40),
  //                               child: Column(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   TextFormField(
  //                                     obscureText: false,
  //                                     controller: name,
  //                                     // validator: (val) {
  //                                     //   return validator(val!, 3, 20);
  //                                     // },
  //                                     decoration: InputDecoration(
  //                                         icon: Icon(
  //                                           Icons.person_outline,
  //                                           color: Color(navyBlue),
  //                                           size: 30,
  //                                         ),
  //                                         hintText: "User name",
  //                                         hintStyle: TextStyle(
  //                                             color: Color(navyBlue),
  //                                             fontWeight: FontWeight.w300),
  //                                         border: InputBorder.none),
  //                                   ),
  //                                   Divider(
  //                                     color: Colors.grey.shade500,
  //                                     thickness: 1,
  //                                   ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   TextFormField(
  //                                     obscureText: false,
  //                                     controller: email,
  //                                     // validator: (val) {
  //                                     //   return validator(val!, 3, 40);
  //                                     // },
  //                                     decoration: InputDecoration(
  //                                         icon: Icon(
  //                                           Icons.email,
  //                                           color: Color(navyBlue),
  //                                           size: 30,
  //                                         ),
  //                                         hintText: "Email",
  //                                         hintStyle: TextStyle(
  //                                             color: Color(navyBlue),
  //                                             fontWeight: FontWeight.w300),
  //                                         border: InputBorder.none),
  //                                   ),
  //                                   Divider(
  //                                     color: Colors.grey.shade500,
  //                                     thickness: 1,
  //                                   ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   TextFormField(
  //                                     obscureText: true,
  //                                     controller: password,
  //                                     // validator: (val) {
  //                                     //   return validator(val!, 3, 20);
  //                                     // },
  //                                     decoration: InputDecoration(
  //                                         icon: Icon(
  //                                           Icons.lock,
  //                                           color: Color(navyBlue),
  //                                           size: 30,
  //                                         ),
  //                                         hintText: "Password",
  //                                         hintStyle: TextStyle(
  //                                             color: Color(navyBlue),
  //                                             fontWeight: FontWeight.w300),
  //                                         border: InputBorder.none),
  //                                   ),
  //                                   Divider(
  //                                     color: Colors.grey.shade500,
  //                                     thickness: 1,
  //                                   ),
  //                                   SizedBox(
  //                                     height: 20,
  //                                   ),
  //                                   Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       DropdownButton(
  //                                         hint: Text('type'),
  //                                         items: [
  //                                           'Bachelor_Degree',
  //                                           'Master_Degree'
  //                                         ]
  //                                             .map((e) => DropdownMenuItem(
  //                                                 child: Text('$e'), value: e))
  //                                             .toList(),
  //                                         onChanged: (val) {
  //                                           setState(() {
  //                                             type = val!;
  //                                           });
  //                                         },
  //                                         value: type,
  //                                       ),
  //                                       DropdownButton(
  //                                         hint: Text('year'),
  //                                         items: [
  //                                           'first',
  //                                           'second',
  //                                           'third',
  //                                           'fourth',
  //                                           'fifth'
  //                                         ]
  //                                             .map((e) => DropdownMenuItem(
  //                                                 child: Text('$e'), value: e))
  //                                             .toList(),
  //                                         onChanged: (val) {
  //                                           setState(() {
  //                                             year = val!;
  //                                           });
  //                                         },
  //                                         value: year,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   DropdownButton(
  //                                     hint: Text('specializations'),
  //                                     items: [
  //                                       'جراحة',
  //                                       'طب أسنان الأطفال',
  //                                       'أمراض الفم',
  //                                       'تقويم',
  //                                       'لثة',
  //                                       'تعويضات المتحركة',
  //                                       'تعويضات الثابتة',
  //                                       'تجميل',
  //                                       'لبية'
  //                                     ]
  //                                         .map((e) => DropdownMenuItem(
  //                                             child: Text('$e'), value: e))
  //                                         .toList(),
  //                                     onChanged: (val) {
  //                                       setState(() {
  //                                         specializations = val!;
  //                                       });
  //                                     },
  //                                     value: specializations,
  //                                   ),
  //                                   Row(
  //                                     children: [
  //                                       IconButton(
  //                                           onPressed: () {
  //                                             pickerCamera();
  //                                           },
  //                                           color: Color(navyBlue),
  //                                           icon: Icon(
  //                                               Icons.camera_enhance_sharp)),
  //                                       Text(
  //                                         'Add your college picture card',
  //                                         style: TextStyle(
  //                                             fontSize: 15,
  //                                             color: Color(navyBlue)),
  //                                       )
  //                                     ],
  //                                   ),
  //                                   SizedBox(
  //                                     height: 30,
  //                                   ),
  //                                   ElevatedButton(
  //                                     onPressed: () async {
  //                                       await post();
  //                                     },
  //                                     child: Text(
  //                                       "Create",
  //                                       style: TextStyle(
  //                                           fontSize: 20,
  //                                           color: Colors.grey.shade700),
  //                                     ),
  //                                     style: ElevatedButton.styleFrom(
  //                                       shape: StadiumBorder(),
  //                                       backgroundColor:
  //                                           Colors.blueGrey.shade100,
  //                                       padding: EdgeInsets.symmetric(
  //                                           vertical: 16, horizontal: 120),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //   );
  // }
}
