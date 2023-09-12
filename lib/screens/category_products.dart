import 'dart:developer';

import 'package:ecommerce_bootcampapp/screens/detailpage.dart';
import 'package:ecommerce_bootcampapp/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Category_productsPage extends StatefulWidget {
  String catname;
  int catid;
  Category_productsPage({required this.catid, required this.catname});
  @override
  State<Category_productsPage> createState() => _Category_productsPageState();
}

class _Category_productsPageState extends State<Category_productsPage> {
  @override
  Widget build(BuildContext context) {
    log("catname = " + widget.catname.toString());
    log("catid = " + widget.catid.toString());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.catname,
          // "Category name",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
          future: Webservice().fetchCatProducts(widget.catid),
          builder: (context, snapshot) {
            // log("length ==" + snapshot.data!.length.toString());
            if (snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
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
                              image: Webservice().imageurl + procduct.image!,
                              price: procduct.price.toString(),
                              description: procduct.description!,
                            );
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
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
                                    Webservice().imageurl + procduct.image!,
                                  )
                                      //  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGUU3VWK2nTbvZRiUCORkJJ80S4JrCoCqoYQ&usqp=CAU"),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        procduct.productname!,

                                        ///  "Shoessssssssssssssssssssssssssssssssssggggggggggggggggggggggsssssssss",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Rs. ',
                                              style: TextStyle(
                                                  color: Colors.red.shade900,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              //  "2000",
                                              procduct.price.toString(),

                                              style: TextStyle(
                                                  color: Colors.red.shade900,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
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
                      const StaggeredTile.fit(1));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
