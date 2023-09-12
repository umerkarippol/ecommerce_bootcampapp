import 'dart:developer';

import 'package:ecommerce_bootcampapp/constants.dart';
import 'package:ecommerce_bootcampapp/login.dart';
import 'package:ecommerce_bootcampapp/provider/cart_provider.dart';
import 'package:ecommerce_bootcampapp/screens/cartpage.dart';
import 'package:ecommerce_bootcampapp/screens/home.dart';
import 'package:ecommerce_bootcampapp/screens/orderdetailspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "E-COMMERCE",
                  style: TextStyle(
                      color: maincolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: badges.Badge(
                  showBadge:
                      //  true,
                      context.read<Cart>().getItems.isEmpty ? false : true,
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                  badgeContent: Text(
                    context.watch<Cart>().getItems.length.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                    // size: 15,
                  )),
              //const Icon(Icons.shopping_cart),
              title: const Text(
                'Cart page',
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text(
                'Order Details',
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                // OrderdetailsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderdetailsPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new_rounded,
                  color: Colors.red.shade900),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
