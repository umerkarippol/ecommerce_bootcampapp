import 'dart:developer';

import 'package:ecommerce_bootcampapp/constants.dart';
import 'package:ecommerce_bootcampapp/drawer.dart';
import 'package:ecommerce_bootcampapp/main.dart';
import 'package:ecommerce_bootcampapp/models/product_model.dart';
import 'package:ecommerce_bootcampapp/screens/category_products.dart';
import 'package:ecommerce_bootcampapp/screens/detailpage.dart';
import 'package:ecommerce_bootcampapp/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        backgroundColor: maincolor,
        title: Text(
          "E-COMMERCE",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Category",
              style: TextStyle(
                  fontSize: 20, color: maincolor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: Webservice().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    log("length ==" + snapshot.data!.length.toString());
                    return Container(
                      height: 80,
                      //  color: Colors.amber,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            // 13,
                            snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                log("clicked");

                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Category_productsPage(
                                      //  catid: ,catname: ,
                                      catid: snapshot.data![index].id!,
                                      catname: snapshot.data![index].category!,
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(37, 5, 2, 39),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].category!,
                                    // "Cateogry name",
                                    style: TextStyle(
                                        color: maincolor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              "Offer Products",
              style: TextStyle(
                  fontSize: 18, color: maincolor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),

            //view products
            Expanded(
              child: FutureBuilder(
                  future: Webservice().fetchProducts(),
                  builder: (context, snapshot) {
                    //  log("product length ==" + snapshot.data!.length.toString());
                    if (snapshot.hasData) {
                      return Container(
                        // color: Colors.amber,
                        child: StaggeredGridView.countBuilder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                //  14,
                                snapshot.data!.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              final procduct = snapshot.data![index];
                              return InkWell(
                                onTap: () {
                                  log("clicked");
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailsPage(
                                          id: procduct.id!,
                                          name: procduct.productname!,
                                          image: Webservice().imageurl +
                                              procduct.image!,
                                          price: procduct.price.toString(),
                                          description: procduct.description!);
                                    },
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 100, maxHeight: 250),
                                            child: Image(
                                                image: NetworkImage(
                                              Webservice().imageurl +
                                                  procduct.image!,
                                              // "a"+"b"="ab";
                                              // "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                                              // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGUU3VWK2nTbvZRiUCORkJJ80S4JrCoCqoYQ&usqp=CAU",
                                            )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  procduct.productname!,
                                                  //  "Shoes ssssssssssssssssssssssssssssssss",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rs. ' +
                                                      procduct.price.toString(),
                                                  //  "2000",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade900,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (context) =>
                                const StaggeredTile.fit(1)),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),

            //closing
          ],
        ),
      ),
    );
  }
}
