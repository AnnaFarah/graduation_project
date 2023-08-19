import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appColor.dart';
import 'package:newstart/store/getProducts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(white),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          IconButton(
            onPressed: () {
              Get.off(GetStoreProducts());
            },
            icon: Icon(Icons.arrow_back),
            color: Color(black),
            iconSize: 35,
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
                Get.off(GetStoreProducts());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Added successfully",
                    style: TextStyle(fontSize: 20),
                  ),
                ));
              },
              child: Text(
                'confirm',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(newOrange), fixedSize: Size(120, 16)),
            ),
          ),
        ]),
      ),
    );
  }
}
