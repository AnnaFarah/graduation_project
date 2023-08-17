import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';
import 'package:newstart/constant/appliApis.dart';
import 'package:newstart/lab/getAvailableTime.dart';
import 'package:newstart/store/addProduct.dart';
import 'package:newstart/store/basket.dart';
import 'package:newstart/store/productInfo.dart';
import 'package:newstart/studentScreens/homePageFroStudents.dart';

import '../constant/appColor.dart';
import '../main.dart';
import '../studentScreens/studentShowCalendar.dart';

class GetStoreProducts extends StatefulWidget {
  @override
  State<GetStoreProducts> createState() => _GetStoreProductsState();
}

class _GetStoreProductsState extends State<GetStoreProducts> {
  GlobalKey<FormState> formKey = GlobalKey();

  int currentIndex = 2;

  bool isLoading = false;

  GetPost getPost = GetPost();

  List products = [];

  getAllProducts() async {
    isLoading = true;
    setState(() {});

    var responseBody = await getPost.getRequest('${url}/api/allProducts', {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });

    isLoading = false;
    setState(() {});

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
    return Scaffold(
      backgroundColor: Color(white),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 10),
                child: Text('University store',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 120, top: 10),
                child: Divider(
                  thickness: 1,
                  color: Color(black),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              products.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 210),
                      child: Center(
                        child: Text('Empty',
                            style: TextStyle(
                                fontSize: 25, color: Colors.grey.shade700)),
                      ),
                    )
                  : Expanded(
                      flex: 6,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 30,
                        ),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProductInfo productInfo = ProductInfo(
                              id: products[index]['id'],
                              name: products[index]['name'],
                              price: products[index]['price'],
                              photo: products[index]['photo'],
                              discount: products[index]['discount_value']);
                          return ElevatedButton(
                            onPressed: () {
                              Get.to(AddProduct(
                                id: productInfo.id,
                                name: productInfo.name,
                                price: productInfo.price,
                                photo: productInfo.photo,
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                // side: BorderSide(
                                //     color: Color(darkBlue), width: 1),
                                foregroundColor: Color(darkBlue),
                                backgroundColor: Color(white),
                                elevation: 0,
                                //padding: EdgeInsets.all(10),
                                fixedSize: Size(20, 60)),
                            child: Column(
                              children: [
                                productInfo.photo != null
                                    ?
                                    //ShowProducts(productInfo: productInfo)
                                    Image.network(
                                        productInfo.photo,
                                        height: 150,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : SizedBox(),
                                Text(
                                  '${productInfo.name}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text('${productInfo.price}',
                                    style: TextStyle(
                                        fontSize: 15, color: Color(newOrange)))
                              ],
                            ),
                          );
                        },
                      ))
            ]),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(Basket());
          },
          backgroundColor: Color(NewDarkBlue),
          label: Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                  color: Color(NewDarkBlue),
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(
                'icons/cart-shopping-fast.png',
                height: 10,
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedLabelStyle: TextStyle(color: Color(darkBlue)),
        onTap: (value) {
          setState(() {
            currentIndex = value;
            if (currentIndex == 0) {
              Get.off(HomePageForStudents());
            } else if (currentIndex == 1) {
              Get.to(ShowStudentCalendar());
            } else if (currentIndex == 2) {
              Get.off(GetStoreProducts());
            } else if (currentIndex == 3) {
              Get.off(GetAvailableTime());
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'icons/home.png',
                height: 25,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'icons/calendar.png',
                height: 25,
              ),
              label: 'calendar'),
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/shopping-cart-add.png',
              height: 25,
            ),

            // Image.asset('icons/shopping-cart-add.png'),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'icons/teeth-open1.png',
              height: 25,
            ),
            label: 'X-ray',
          ),
        ],
      ),
    );
  }
}
