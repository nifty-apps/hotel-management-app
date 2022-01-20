import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samudra_bilash_hotel/controller/auth_controller.dart';
import 'package:samudra_bilash_hotel/view/screens/home/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidepassword = true;
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Center(
        child: new ClipRect(
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Expanded(
              child: new Container(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: new Text(
                          "Login App",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textScaleFactor: 2.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "SAMUDRO BILASH",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      new Form(
                        key: formKey,
                        child: Expanded(
                          child: new Column(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new TextFormField(
                                  controller: emailController,
                                  cursorColor: Colors.blue,
                                  //onSaved: (val) => _username = val!,
                                  validator: (val) {
                                    return val!.length < 10
                                        ? "Username must have atleast 10 chars"
                                        : null;
                                  },
                                  decoration: new InputDecoration(
                                      labelText: "Username",
                                      hintText: "Username",
                                      labelStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.blueAccent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent))),
                                ),
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new TextFormField(
                                  controller: passwordController,
                                  cursorColor: Colors.blue,
                                  obscureText: hidepassword,
                                  // onSaved: (val) => _password = val!,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your password";
                                    }
                                  },
                                  decoration: new InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidepassword = !hidepassword;
                                        });
                                      },
                                      icon: hidepassword
                                          ? Icon(
                                              Icons.visibility,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                    ),
                                    labelText: "Password",
                                    hintText: "Password",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.blueAccent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.blueAccent),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      bool success = await controller.login(
                                        emailController.text.toString(),
                                        passwordController.text.toString(),
                                      );
                                      if (success) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ),
                                            (route) => false);
                                        Get.snackbar(
                                            "Login", "Login successfully",
                                            colorText: Colors.white,
                                            backgroundColor: Colors.black,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      minimumSize: Size(200, 45),
                                      backgroundColor: Colors.blue),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "@ Admin login page provide information.",
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.5)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                    // crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                height: 450,
                width: 300.0,
                decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
