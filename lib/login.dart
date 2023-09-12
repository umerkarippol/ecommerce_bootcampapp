import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_bootcampapp/constants.dart';
import 'package:ecommerce_bootcampapp/registration.dart';
import 'package:ecommerce_bootcampapp/screens/home.dart';
import 'package:ecommerce_bootcampapp/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log("isloggedin = " + isLoggedIn.toString());
    if (isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  //login function
  login(String username, String password) async {
    try {
      print('webservice');
      print(username);
      print(password);
      var result;
      final Map<String, dynamic> loginData = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse(Webservice.mainurl + "login.php"),
        body: loginData,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("login successfully completed");
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("username", username);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ));
        } else {
          log("login failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("LOGIN FAILED !!!",
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
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 200),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Login with your username and password  \n",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
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
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Username',
                        ),
                        onChanged: (text) {
                          setState(() {
                            username = text;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your username text';
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
                        obscureText: true,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Password',
                        ),
                        onChanged: (text) {
                          setState(() {
                            password = text;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your password text';
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // processing == true
              //     ? const Center(
              //         child: CircularProgressIndicator(
              //         color: Color.fromARGB(255, 7, 2, 78),
              //       ))
              //     :
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
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
                        log("username = " + username.toString());
                        log("password = " + password.toString());
                        login(username.toString(), password.toString());
                      }
                    },
                    child: Text(
                      "Login",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: TextStyle(fontSize: 16),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RegistrationPage();
                        },
                      ));
                    },
                    child: Text(
                      "Go to Register",
                      style: TextStyle(
                          fontSize: 16,
                          color: maincolor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
