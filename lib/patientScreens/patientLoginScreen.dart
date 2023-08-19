import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/Controller/loginController.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/component/validator.dart';
import 'package:newstart/patientScreens/patient_home_page.dart';
import 'package:newstart/patientScreens/signupScreen.dart';

import '../choseLoginType.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class patientLoginScreen extends StatefulWidget {
  @override
  State<patientLoginScreen> createState() => _patientLoginScreenState();
}

class _patientLoginScreenState extends State<patientLoginScreen> {
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
        {
          'Accept': 'application/json',
        },
      );

      isLoading = false;
      setState(() {});

      if (response["message"] == 'User signed in') {
        patientSharedPreferences.setString(
            'token', response['data']['token'].toString());
        patientSharedPreferences.setString(
            'id', response['data']['id'].toString());
        patientSharedPreferences.setString(
            'name', response['data']['name'].toString());
        print(response);
        // await registerOnFirebase(true);

        Get.off(PatientHomePage());
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
        resizeToAvoidBottomInset: false,
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(faintBlue),
                  Color(faintGreen),
                ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                child: GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (controller) => ListView(children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.off(ChoseLoginType());
                                  },
                                  icon: Icon(Icons.arrow_back),
                                  color: Color(navyBlue),
                                  iconSize: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: Image.asset(
                                      'icons/wired-outline-21-avatar.gif',
                                      height: 120,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 5),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        obscureText: false,
                                        controller: email,
                                        validator: (val) {
                                          return validator(val!, 3, 40);
                                        },
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.person_outline,
                                              color: Color(navyBlue),
                                              size: 30,
                                            ),
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                                color: Color(navyBlue),
                                                fontWeight: FontWeight.w300),
                                            border: InputBorder.none),
                                      ),
                                      Divider(
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        controller: password,
                                        validator: (val) {
                                          return validator(val!, 3, 20);
                                        },
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.lock,
                                              color: Color(navyBlue),
                                              size: 30,
                                            ),
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Color(navyBlue),
                                                fontWeight: FontWeight.w300),
                                            border: InputBorder.none),
                                      ),
                                      Divider(
                                        color: Colors.grey.shade500,
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      MaterialButton(
                                        color: Colors.blueGrey.shade100,
                                        onPressed: () async {
                                          await tologin();
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff153762)),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 120),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Dont have an account?',
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: TextButton(
                                            onPressed: () {
                                              Get.to(SignupScreen());
                                            },
                                            child: Text(
                                              "create new account"
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(navyBlue)),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ));
  }
}
