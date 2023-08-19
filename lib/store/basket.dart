import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newstart/store/cart.dart';
import 'package:newstart/store/getProducts.dart';

import '../component/getAndPost.dart';
import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';

class Basket extends StatefulWidget {
  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  bool isLoading = false;
  GetPost getPost = GetPost();
  GlobalKey<FormState> formKey = GlobalKey();

  sendProducts() async {
    isLoading = true;
    setState(() {});

    var request = http.Request('POST', Uri.parse('${url}/api/addOrder'));
    request.body = json.encode({"products": MyCart.data});
    request.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.off(GetStoreProducts());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Done",
          style: TextStyle(fontSize: 20),
        ),
      ));
      MyCart.data.clear();
    } else {
      print(response.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error? something went wrong",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 330, top: 30),
                  child: IconButton(
                    onPressed: () {
                      Get.off(GetStoreProducts());
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Color(black),
                    iconSize: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 250, top: 20),
                  child: Text('51'.tr,
                      style: TextStyle(
                          color: Color(newOrange),
                          fontSize: 27,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Name'),
                    Text('Quantity'),
                    Text('Price(per unit)')
                  ],
                ),
                Divider(color: Colors.grey.shade400),
                MyCart.data.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 210),
                        child: Center(
                          child: Text('Empty',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.grey.shade700)),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: MyCart.data.length,
                            itemBuilder: (context, i) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${MyCart.fullData[i]['name']}'),
                                  // SizedBox(
                                  //   width: 50,
                                  // ),
                                  Text('${MyCart.fullData[i]['quantity']}'),
                                  // SizedBox(
                                  //   width: 50,
                                  // ),
                                  Text('${MyCart.fullData[i]['price']}'),
                                ],
                              );
                            }),
                      ),
                SizedBox(
                  height: 10,
                ),
                MyCart.data.isEmpty
                    ? SizedBox()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Color(newOrange),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                        ),
                        onPressed: () async {
                          await sendProducts();
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(fontSize: 15),
                        ))
              ],
            )));
  }
}
