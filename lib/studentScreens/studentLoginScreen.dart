import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/main.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';
import 'package:newstart/studentScreens/studentSignup.dart';

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
        Get.off(HomePageForStudents());
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
      //backgroundColor: Color(newblack),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/newBackground.JPG"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Form(
              key: formKey,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(right: 240, top: 80),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 300, top: 50),
                  child: Text(
                    'Email:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Email",
                      //enabledBorder: OutlineInputBorder()
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 260, top: 40),
                  child: Text(
                    'Password:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                        hintText: "...............",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () async {
                      await tologin();
                    },
                    child: isLoading == true
                        ? CircularProgressIndicator(
                            color: Color(white),
                          )
                        : Text(
                            'Login',
                            style: TextStyle(color: Color(white), fontSize: 19),
                          ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        backgroundColor: Color(NewDarkBlue),
                        fixedSize: Size(220, 50)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Dont have an account?',
                  style: TextStyle(color: Color(black), fontSize: 17),
                ),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                    onPressed: () {
                      Get.to(StudentSignup());
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Color(newOrange),
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    ))
              ]),
            )
          ],
        ),
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
