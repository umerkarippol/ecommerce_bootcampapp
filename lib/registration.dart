import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_bootcampapp/constants.dart';
import 'package:ecommerce_bootcampapp/login.dart';
import 'package:ecommerce_bootcampapp/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? name, phone, address, username, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // bool processing = false;
  registration(String name, phone, address, username, password) async {
    try {
      print(username);
      print(password);
      var result;
      final Map<String, dynamic> Data = {
        'name': name,
        'phone': phone,
        'address': address,
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse(Webservice.mainurl + "registration.php"
            // Webservice.mainurl + "registration.jsp"
            ),
        body: Data,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("registration successfully completed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("REGISTRATION SUCCESSFULLY COMPLETED",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ));
        } else {
          log("registration failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("REGISTRATION FAILED !!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
        }
      } else {
        result = {log(json.decode(response.body)['error'].toString())};
      }
      return result;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Register Account",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Complete your details  \n",
            ),
            SizedBox(height: 28),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Name ';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                phone = text;
                              });
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter phone ";
                              } else if (value.length > 10 ||
                                  value.length < 10) {
                                return "Please enter valid phone number ";
                              }
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Phone',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Center(
                          child: TextFormField(
                            maxLines: 4,
                            onChanged: (text) {
                              setState(() {
                                address = text;
                              });
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Address',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your address';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                username = text;
                              });
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Username',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your username';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your password ';
                              }
                            },
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // processing == true
                  //     ? const Center(
                  //         child: CircularProgressIndicator(
                  //         color: Color.fromARGB(255, 5, 1, 50),
                  //       ))
                  //     :
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: Colors.white,
                          backgroundColor: maincolor,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log("name = " + name.toString());
                            log("phone = " + phone.toString());
                            log("address = " + address.toString());
                            log("username = " + username.toString());
                            log("password = " + password.toString());
                            registration(
                                name!, phone, address, username, password);
                          }
                        },
                        child: Text(
                          "Register",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Do you have an account? ",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 16,
                        color: maincolor,
                        // Color.fromARGB(255, 5, 1, 50),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
