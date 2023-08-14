import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/validator.dart';
import 'package:newstart/constant/appliApis.dart';
import 'package:newstart/patientScreens/patientLoginScreen.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../main.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController age = TextEditingController();

  //final TextEditingController gender = TextEditingController();

  final TextEditingController description = TextEditingController();

  var gender1 = 'Female';

  GetPost getPost = GetPost();

  bool isLoading = false;

  toSignUp() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await getPost.postRequest(signUpApi, {
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'age': age.text,
        'gender': gender1,
        'description': 'difoaj'
      }, {
        'Accept': 'application/json'
      });

      isLoading = false;
      setState(() {});

      if (response["message"] == 'Patient signed up successfully.') {
        patientSharedPreferences.setString(
            'token', response['data']['token'].toString());
        patientSharedPreferences.setString(
            'name', response['data']['name'].toString());
        Get.off(patientLoginScreen());
      } else {
        print("login catch error");
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
              child: ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.off(patientLoginScreen());
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Color(navyBlue),
                          iconSize: 30,
                        ),
                        Center(
                          child: Text(
                            'Create new account',
                            style: TextStyle(
                                fontFamily: 'cookie',
                                fontSize: 45,
                                color: Color(navyBlue)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 5),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      obscureText: false,
                                      controller: name,
                                      validator: (val) {
                                        return validator(val!, 3, 20);
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.person_outline,
                                            color: Color(navyBlue),
                                            size: 30,
                                          ),
                                          hintText: "User name",
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
                                      height: 5,
                                    ),
                                    TextFormField(
                                      obscureText: false,
                                      controller: email,
                                      validator: (val) {
                                        return validator(val!, 3, 40);
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.email,
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
                                      height: 5,
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
                                      height: 5,
                                    ),
                                    TextFormField(
                                      obscureText: false,
                                      controller: age,
                                      validator: (val) {
                                        return validator(val!, 1, 3);
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.person_outline,
                                            color: Color(navyBlue),
                                            size: 30,
                                          ),
                                          hintText: "age",
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
                                      height: 15,
                                    ),
                                    DropdownButton(
                                      hint: Text('Gender'),
                                      items: ['Female', 'Male']
                                          .map((e) => DropdownMenuItem(
                                              child: Text('$e'), value: e))
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          gender1 = val!;
                                        });
                                      },
                                      value: gender1,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await toSignUp();
                                      },
                                      child: Text(
                                        "Create",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade700),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        backgroundColor:
                                            Colors.blueGrey.shade100,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 120),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
