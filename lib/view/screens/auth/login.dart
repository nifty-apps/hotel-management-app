import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/controller/auth_provider.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authProvider);
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
                          provider
                              .login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            context,
                          )
                              .then((value) {
                            if (value == true) {
                              if (provider.userData.hotel != null) {
                                Navigator.pushReplacementNamed(
                                    context, Routes.dashboard);
                              } else {
                                Navigator.pushNamed(context, Routes.addHotel);
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
                              Navigator.pushReplacementNamed(
                                  context, Routes.signUp);
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
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
