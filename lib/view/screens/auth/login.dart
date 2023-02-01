import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/controller/auth_controller.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';
import 'package:hotel_management/view/screens/auth/add_hotel.dart';
import 'package:hotel_management/view/screens/auth/registration.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF1F8FF),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Email',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          isPassword: true,
                          controller: passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          onPressed: () {
                            Get.find<AuthController>()
                                .login(emailController.text.trim(),
                                    passwordController.text.trim(), context)
                                .then((value) {
                              if (value == true) {
                                if (Get.find<AuthController>()
                                        .userData!
                                        .hotel !=
                                    null) {
                                  Get.offAll(() => DashboardScreen(),
                                      transition: Transition.fadeIn);
                                } else {
                                  Get.to(() => AddHotel(),
                                      transition: Transition.fadeIn);
                                }
                              }
                            });
                          },
                          buttonText: 'Login',
                          width: 200,
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Haven't an account?"),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => Registration(),
                                      transition: Transition.fadeIn);
                                },
                                child: Text('Sign up'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
