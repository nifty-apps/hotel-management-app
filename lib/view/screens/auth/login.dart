import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/controller/auth_controller.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';
import 'package:hotel_management/view/screens/auth/add_hotel.dart';
import 'package:hotel_management/view/screens/auth/registration.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard_screen.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              SizedBox(height: 10),
              Flexible(
                flex: 1,
                child: Image.asset(
                  'assets/images/login.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 50),
              Flexible(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email',
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        isPassword: true,
                      ),
                      SizedBox(height: 30),
                      CustomButton(
                        onPressed: () {
                          Get.find<AuthController>()
                              .login(emailController.text.trim(),
                                  passwordController.text.trim(), context)
                              .then((value) {
                            if (value == true) {
                              if (Get.find<AuthController>().userData.hotel !=
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
                        width: double.infinity,
                        height: 48,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Haven't an account?"),
                          TextButton(
                            onPressed: () {
                              Get.to(() => Registration(),
                                  transition: Transition.fadeIn);
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
