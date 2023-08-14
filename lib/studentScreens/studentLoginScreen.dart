import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/component/textField.dart';
import 'package:newstart/main.dart';
import 'package:newstart/studentScreens/studentSignup.dart';
import 'package:newstart/studentScreens/student_home_page.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';

class StudentLoginScreen extends StatefulWidget {
  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  GetPost getPost = GetPost();

  bool isLoading = false;

  tologin() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await getPost.postRequest(
          '${url}/api/login',
          {'email': email.text, 'password': password.text},
          {'Accept': 'application/json'});

      isLoading = false;
      setState(() {});

      if (response["message"] == 'User signed in') {
        var studentType = response['data']['students'][0]['type'];
        print(studentType);
        studentSharedPreferences.setString(
            'token', response['data']['token'].toString());
        studentSharedPreferences.setString(
            'id', response['data']['id'].toString());
        studentSharedPreferences.setString('type', studentType);
        studentSharedPreferences.setString(
            'name', response['data']['name'].toString());
        Get.off(HomePageS());
      } else if (response["message"] == "Unauthorised.") {
        print("login catch error");
        AwesomeDialog(
            context: context,
            title: "Alert!!",
            body: Text("Wrong email or password"))
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(newblack),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              child:
                  Container(decoration: BoxDecoration(color: Color(newblack)))),
          Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 220, top: 30),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 30,
                                color: Color(newblack),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35, right: 35, top: 50),
                          child: TextFieldComponent(
                              hint: 'Username', myController: email),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35, right: 35, top: 20),
                          child: TextFieldComponent(
                              hint: 'Password', myController: password),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 90),
                          child: ElevatedButton(
                            onPressed: () async {
                              await tologin();
                            },
                            child: isLoading == true
                                ? CircularProgressIndicator(
                                    color: Color(newblack),
                                  )
                                : Text(
                                    'Confirm',
                                    style: TextStyle(
                                        color: Color(newblack), fontSize: 17),
                                  ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                backgroundColor: Color(newlightGreen),
                                fixedSize: Size(220, 50)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Dont have an account?',
                          style: TextStyle(color: Color(newblack)),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(StudentSignup());
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Color(newblack),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23),
                            ))
                      ]),
                ),
                decoration: BoxDecoration(
                    color: Color(newgrey),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
              ))
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       resizeToAvoidBottomInset: false,
  //       body: isLoading == true
  //           ? Center(child: CircularProgressIndicator())
  //           : Container(
  //               width: double.infinity,
  //               height: double.infinity,
  //               decoration: BoxDecoration(
  //                   gradient: LinearGradient(colors: [
  //                 Color(faintBlue),
  //                 Color(faintGreen),
  //               ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
  //               child: GetBuilder<LoginController>(
  //                   init: LoginController(),
  //                   builder: (controller) => ListView(children: [
  //                         Form(
  //                           key: formKey,
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Container(
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     IconButton(
  //                                       onPressed: () {
  //                                         Get.off(ChoseLoginType());
  //                                       },
  //                                       icon: Icon(Icons.arrow_back),
  //                                       color: Color(navyBlue),
  //                                       iconSize: 30,
  //                                     ),
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(top: 5),
  //                                       child: Center(
  //                                         child: Image.asset(
  //                                           'icons/wired-outline-21-avatar.gif',
  //                                           height: 120,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 50,
  //                                     ),
  //                                     Container(
  //                                       margin:
  //                                           EdgeInsets.symmetric(vertical: 10),
  //                                       padding: EdgeInsets.symmetric(
  //                                           horizontal: 40, vertical: 5),
  //                                       child: Column(
  //                                         children: [
  //                                           TextFormField(
  //                                             keyboardType:
  //                                                 TextInputType.emailAddress,
  //                                             obscureText: false,
  //                                             controller: email,
  //                                             validator: (val) {
  //                                               return validator(val!, 3, 40);
  //                                             },
  //                                             decoration: InputDecoration(
  //                                                 icon: Icon(
  //                                                   Icons.person_outline,
  //                                                   color: Color(navyBlue),
  //                                                   size: 30,
  //                                                 ),
  //                                                 hintText: "Email",
  //                                                 hintStyle: TextStyle(
  //                                                     color: Color(navyBlue),
  //                                                     fontWeight:
  //                                                         FontWeight.w300),
  //                                                 border: InputBorder.none),
  //                                           ),
  //                                           Divider(
  //                                             color: Colors.grey.shade500,
  //                                             thickness: 1,
  //                                           ),
  //                                           SizedBox(
  //                                             height: 20,
  //                                           ),
  //                                           TextFormField(
  //                                             obscureText: true,
  //                                             controller: password,
  //                                             validator: (val) {
  //                                               return validator(val!, 3, 20);
  //                                             },
  //                                             decoration: InputDecoration(
  //                                                 icon: Icon(
  //                                                   Icons.lock,
  //                                                   color: Color(navyBlue),
  //                                                   size: 30,
  //                                                 ),
  //                                                 hintText: "Password",
  //                                                 hintStyle: TextStyle(
  //                                                     color: Color(navyBlue),
  //                                                     fontWeight:
  //                                                         FontWeight.w300),
  //                                                 border: InputBorder.none),
  //                                           ),
  //                                           Divider(
  //                                             color: Colors.grey.shade500,
  //                                             thickness: 1,
  //                                           ),
  //                                           SizedBox(
  //                                             height: 50,
  //                                           ),
  //                                           MaterialButton(
  //                                             color: Colors.blueGrey.shade100,
  //                                             onPressed: () async {
  //                                               await tologin();
  //                                             },
  //                                             child: Text(
  //                                               "Login",
  //                                               style: TextStyle(
  //                                                   fontSize: 20,
  //                                                   color: Color(0xff153762)),
  //                                             ),
  //                                             padding: EdgeInsets.symmetric(
  //                                                 vertical: 16,
  //                                                 horizontal: 120),
  //                                           ),
  //                                           SizedBox(
  //                                             height: 20,
  //                                           ),
  //                                           Text(
  //                                             'Dont have an account?',
  //                                             style: TextStyle(
  //                                                 color: Colors.grey.shade500,
  //                                                 fontWeight: FontWeight.w500),
  //                                           ),
  //                                           Padding(
  //                                             padding: const EdgeInsets.only(
  //                                                 top: 30),
  //                                             child: TextButton(
  //                                                 onPressed: () {
  //                                                   Get.to(StudentSignup());
  //                                                 },
  //                                                 child: Text(
  //                                                   "create new account"
  //                                                       .toUpperCase(),
  //                                                   style: TextStyle(
  //                                                       fontSize: 18,
  //                                                       color: Color(navyBlue)),
  //                                                 )),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                       ]))));
  // }
}
