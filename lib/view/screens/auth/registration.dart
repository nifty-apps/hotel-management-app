import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/controller/auth_controller.dart';
import 'package:hotel_management/model/body/registration.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';
import 'package:hotel_management/view/screens/auth/add_hotel.dart';
import 'package:hotel_management/view/screens/auth/login.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Registration'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: GetBuilder<AuthController>(builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  child: Image.asset('assets/images/signup.jpg'),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: controller.nameController,
                  hintText: 'Name',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: controller.phoneController,
                  hintText: 'Phone',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: controller.roleController,
                  hintText: 'Role',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: controller.pasController,
                  hintText: 'Password',
                  isPassword: true,
                ),
                SizedBox(height: 16),
                CustomButton(
                  onPressed: () {
                    RegistrationModel registration = RegistrationModel(
                      name: controller.nameController.text,
                      email: controller.emailController.text,
                      phone: controller.phoneController.text,
                      role: controller.roleController.text,
                      password: controller.pasController.text,
                    );
                    controller
                        .registration(registration, context)
                        .then((value) {
                      if (value == true) {
                        Get.offAll(
                          () => AddHotel(),
                          transition: Transition.fadeIn,
                        );
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
                          Get.to(() => LoginPage(),
                              transition: Transition.fadeIn);
                        },
                        child: Text('Login'))
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
