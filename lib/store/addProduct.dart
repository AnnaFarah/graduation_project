import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/constant/appliApis.dart';
import 'package:newstart/store/getProducts.dart';

import '../main.dart';
import 'cart.dart';

class AddProduct extends StatefulWidget {
  final int id;
  final String name;
  final String price;
  final String photo;
  AddProduct(
      {required this.id,
      required this.name,
      required this.price,
      required this.photo});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int counter = 0;

  bool isLoading = false;

  GetPost getPost = GetPost();

  buyProduct() async {
    isLoading = true;
    setState(() {});

    var responseBody =
        await getPost.postRequest('${url}/api/addOrder/${widget.id}', {
      'Quantity': counter.toString()
    }, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    if (responseBody['message'] == 'added Order Done') {
      print('flutter: added product');
      Get.off(GetStoreProducts());
    } else {
      print('flutter: error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(newLightBeige),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: 290),
            child: ElevatedButton(
              onPressed: () {
                Get.off(GetStoreProducts());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(newOrange),
              ),
              child: Icon(Icons.arrow_back),
            ),
          ),
          Image.network(
            widget.photo,
            height: 200,
            width: 150,
          ),
          SizedBox(height: 40),
          Text(
            '${widget.name}',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${widget.price}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 110),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        counter--;
                      });
                    },
                    icon: Icon(Icons.minimize)),
                Text('${counter}'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        counter++;
                      });
                    },
                    icon: Icon(Icons.add)),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                Map<String, int> newProduct = {
                  "id": widget.id,
                  "quantity": counter
                };

                MyCart.data.add(newProduct);

                Map<String, dynamic> newProduct2 = {
                  "name": widget.name,
                  "quantity": counter,
                  "price": widget.price
                };
                MyCart.fullData.add(newProduct2);
              },
              child: Text('confirm'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(newOrange), fixedSize: Size(120, 16)),
            ),
          ),
        ]),
      ),
    );
  }
}
