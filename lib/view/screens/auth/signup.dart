import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/response_message.dart';
import 'package:hotel_management/provider/auth_provider.dart';
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
      body: Consumer(builder: (context, ref, _) {
        final provider = ref.watch(authProvider);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Join Thousands Of Hotailers',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Sign Up To Our Powerful Admin App Now',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
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
                        provider.isLoading
                            ? CircularProgressIndicator()
                            : CustomButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ResponseMessage result =
                                        await provider.sendOtp(
                                      email: emailController.text,
                                    );
                                    showSnackBarMethod(context, result.message,
                                        result.isSuccess);
                                    Navigator.pushNamed(
                                        context, Routes.verifyOtp, arguments: [
                                      nameController.text,
                                      emailController.text,
                                      pasController.text,
                                      true
                                    ]);
                                  }
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
                                  color: Theme.of(context).colorScheme.primary,
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
      }),
    );
  }
}
