import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pasController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (contex, ref, _) {
          // final provider = ref.watch(authProvider);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Container(
                height: 200,
                child: Column(
                  children: [
                    Text(
                      'Join Thousands Of Hotailers',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Sign Up To Our Powerful Admin App Now',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_back),
                              SizedBox(width: 5),
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          CustomTextFormField(
                              controller: nameController,
                              hintText: 'Enter you full name',
                              labelText: 'Full Name',
                              prefixIcon: Icons.person,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter full name';
                                }
                                return null;
                              }),
                          SizedBox(height: 16),
                          CustomTextFormField(
                              controller: emailController,
                              hintText: 'Enter email address',
                              labelText: 'Email',
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please enter email address';
                                }
                                return null;
                              }),
                          SizedBox(height: 16),
                          CustomTextFormField(
                              isPassword: true,
                              controller: pasController,
                              hintText: 'Enter password',
                              labelText: 'Password',
                              prefixIcon: Icons.password,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              }),
                          SizedBox(height: 70),
                          CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print('valid');
                              } else {
                                print('not valid');
                              }
                              // if (!_formKey.currentState!.validate()) {
                              // RegistrationModel registration = RegistrationModel(
                              //   name: nameController.text,
                              //   email: emailController.text,
                              //   phone: phoneController.text,
                              //   role: roleController.text,
                              //   password: pasController.text,
                              // );
                              // provider.registration(registration, contex).then((value) {
                              //   if (value == true) {
                              //     Navigator.pushNamed(context, Routes.addHotel);
                              //   }
                              // });
                            },
                            buttonText: 'Create Account',
                            width: double.infinity,
                            height: 45,
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already a user?",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () =>
                                    Navigator.pushNamed(context, Routes.login),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
