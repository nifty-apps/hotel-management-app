import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassPage extends StatefulWidget {
  ChangePassPage({Key? key}) : super(key: key);

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController oldPassController = TextEditingController();

  final TextEditingController newPassController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  bool hidePassword = true;

  final errorStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Change Password',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textScaleFactor: 2.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'SOMUDRO BILASH',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: oldPassController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your valid username';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Old Password',
                              errorStyle: errorStyle,
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: newPassController,
                            obscureText: hidePassword,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your new password';
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: hidePassword
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                              ),
                              labelText: 'New Password',
                              hintText: 'New Password',
                              errorStyle: errorStyle,
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: confirmPassController,
                            obscureText: hidePassword,
                            textInputAction: TextInputAction.next,
                            // onSaved: (val) => _password = val!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your confirm password';
                              } else if (value != confirmPassController.text) {
                                return "Password doesn't matching";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: hidePassword
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                              ),
                              labelText: 'Confirm Password',
                              hintText: 'Confirm Password',
                              errorStyle: errorStyle,
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
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
                              Get.snackbar(
                                'Password',
                                'Password changed succesfuly',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: Duration(seconds: 3),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            minimumSize: Size(200, 45),
                          ),
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
