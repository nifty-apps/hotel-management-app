import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/controller/auth_provider.dart';
import 'package:hotel_management/models/registration.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pasController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Consumer(builder: (contex, ref, _) {
        final provider = ref.watch(authProvider);
        return Container(
          color: Theme.of(context).colorScheme.background,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset('assets/images/signup.png'),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Name',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: phoneController,
                  hintText: 'Phone',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: roleController,
                  hintText: 'Role',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: pasController,
                  hintText: 'Password',
                  isPassword: true,
                ),
                SizedBox(height: 16),
                CustomButton(
                  onPressed: () {
                    RegistrationModel registration = RegistrationModel(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      role: roleController.text,
                      password: pasController.text,
                    );
                    provider.registration(registration, contex).then((value) {
                      if (value == true) {
                        Navigator.pushNamed(context, Routes.addHotel);
                      }
                    });
                  },
                  buttonText: 'Sign Up',
                  width: double.infinity,
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.login);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
