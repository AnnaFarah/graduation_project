import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/homePageForPatients.dart';
import 'package:newstart/patientScreens/signupScreen.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../firebase-management/getFcmToken.dart';
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
        await registerOnFirebase(true);

        Get.off(HomePageForPatients());
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
                  image: DecorationImage(
                      image: AssetImage("images/newBackground.JPG"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 240, top: 80),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 300, top: 50),
                              child: Text(
                                'Email:',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15),
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
                              padding:
                                  const EdgeInsets.only(right: 260, top: 40),
                              child: Text(
                                'Password:',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 15),
                              child: TextFormField(
                                controller: password,
                                decoration: InputDecoration(
                                    hintText: "...............",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
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
                                        color: Color(newblack),
                                      )
                                    : Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Color(white), fontSize: 19),
                                      ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    backgroundColor: Color(NewDarkBlue),
                                    fixedSize: Size(220, 50)),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Dont have an account?',
                              style:
                                  TextStyle(color: Color(black), fontSize: 17),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(SignupScreen());
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
              ));
  }
}
