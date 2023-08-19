import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                image: DecorationImage(
                    image: AssetImage("images/newBackground.JPG"),
                    fit: BoxFit.cover),
              ),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 240, top: 80),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 250, top: 30),
                      //   child: Text(
                      //     'Username:',
                      //     style: TextStyle(color: Colors.black, fontSize: 20),
                      //   ),
                      // ),
                      SizedBox(height: 30),
                      Container(
                        width: 350,
                        height: 70,
                        child: TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Username",
                            //enabledBorder: OutlineInputBorder()
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 280, top: 20),
                      //   child: Text(
                      //     'Email:',
                      //     style: TextStyle(color: Colors.black, fontSize: 20),
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      Container(
                        width: 350,
                        height: 70,
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              hintText: "Email",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 240, top: 20),
                      //   child: Text(
                      //     'Password:',
                      //     style: TextStyle(color: Colors.black, fontSize: 20),
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      Container(
                        width: 350,
                        height: 70,
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 300, top: 20),
                      //   child: Text(
                      //     'Age:',
                      //     style: TextStyle(color: Colors.black, fontSize: 20),
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      Container(
                        width: 350,
                        height: 70,
                        child: TextFormField(
                          controller: age,
                          decoration: InputDecoration(
                              hintText: "Age",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Gender:",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            width: 20,
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ElevatedButton(
                          onPressed: () async {
                            await toSignUp();
                          },
                          child: isLoading == true
                              ? CircularProgressIndicator(
                                  color: Color(newblack),
                                )
                              : Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Color(white), fontSize: 19),
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
                            Get.to(patientLoginScreen());
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Color(newOrange),
                                fontWeight: FontWeight.w500,
                                fontSize: 25),
                          ))
                    ],
                  ))),
    );
  }
}
