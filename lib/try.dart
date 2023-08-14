import 'package:flutter/material.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appliApis.dart';
import 'package:newstart/store/productInfo.dart';

import 'main.dart';

class TryWidgets extends StatefulWidget {
  @override
  State<TryWidgets> createState() => _TryWidgetsState();
}

class _TryWidgetsState extends State<TryWidgets> {
  bool isLoading = false;
  GetPost getPost = GetPost();
  List products = [];

  getAllProducts() async {
    isLoading = true;
    setState(() {});

    print('in response function');

    var responseBody = await getPost.getRequest('${url}/api/allProducts', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

    print('out response body');

    if (responseBody['message'] == "these are All Products") {
      print('no response body');
      products.addAll(responseBody['data']);
      print('Products : ${products}');
      print('Flutter: done showing products');
    } else {
      print('Flutter: error showing products');
    }
  }

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        ProductInfo productInfo = ProductInfo(
            id: products[index]['id'],
            name: products[index]['name'],
            price: products[index]['price'],
            photo: products[index]['photo'],
            discount: products[index]['discount_value']);
        return Container(
          width: 150,
          height: 200,
          //decoration: BoxDecoration(image: ),
          child: Column(
            children: [
              productInfo.photo != null
                  ?
                  //ShowProducts(productInfo: productInfo)
                  Image.network(
                      productInfo.photo,
                      height: 150,
                      width: 120,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(),
              Text(
                '${productInfo.name}',
                style: TextStyle(fontSize: 10),
              ),
              Text('${productInfo.price}', style: TextStyle(fontSize: 10))
            ],
          ),
        );
      },
    );
  }
}
