import 'dart:developer';

import 'package:ecommerce_bootcampapp/constants.dart';
import 'package:ecommerce_bootcampapp/provider/cart_provider.dart';
import 'package:ecommerce_bootcampapp/screens/cartpage.dart';
import 'package:ecommerce_bootcampapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailsPage extends StatelessWidget {
  String name, price, image, description;
  int id;
  DetailsPage(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.description});
  @override
  Widget build(BuildContext context) {
    log("id = " + id.toString());
    log("name = " + name);
    log("price = " + price);
    log("desc = " + description.toString());
    log("image = " + image.toString());
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.8,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Image(
                          image: NetworkImage(
                            image,
                          ),
                          // "https://www.jiomart.com/images/product/500x630/rvbeuybald/asian-men-s-sports-running-shoes-for-men-product-images-rvbeuybald-0-202305051152.jpg"),
                        ),
                      ),
                      Positioned(
                          left: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return HomePage();
                                  },
                                ));
                              },
                            ),
                          )),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: (20)),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 239, 240, 241),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 2, 20, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              name,
                              // "Shoes",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Rs.  ' + price,
                            // "2000",
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            description,
                            // 'A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function but over time shoes also became fashion items.A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function but over time shoes also became fashion items.A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function but over time shoes also became fashion items.A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function but over time shoes also became fashion items.',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  log("price ==" + double.parse(price).toString());

                  var existingItemCart = context
                      .read<Cart>()
                      .getItems
                      .firstWhereOrNull((element) => element.id == id);
                  // log("existingItemCart----" + existingItemCart.toString());
                  if (existingItemCart != null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: Text("This item already in cart",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ));
                  } else {
                    context
                        .read<Cart>()
                        .addItem(id, name, double.parse(price), 1, image);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      content: Text("Added to cart !!!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ));
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: maincolor),
                  child: Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )));
  }
}
