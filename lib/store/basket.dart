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
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyCart.data.isEmpty
            ? Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.off(GetStoreProducts());
                      },
                      icon: Icon(Icons.arrow_back)),
                  Text('30'.tr)
                ],
              )
            : Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 300, top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(GetStoreProducts());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(newOrange),
                        ),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250, top: 20),
                      child: Text('51'.tr,
                          style: TextStyle(
                              fontFamily: 'cookie',
                              color: Colors.black,
                              fontSize: 35)),
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
                    Expanded(
                      child: ListView.builder(
                          itemCount: MyCart.data.length,
                          itemBuilder: (context, i) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    ElevatedButton(
                        onPressed: () async {
                          await sendProducts();
                        },
                        child: Text('Confirm'))
                  ],
                )));
  }
}
