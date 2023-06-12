import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pasController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (contex, ref, _) {
          final provider = ref.watch(authProvider);
          return Column(
            children: [
              SizedBox(height: 40),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Get Back To Managing Your Hotel Oparations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
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
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                bool isSuccess = await provider.login(
                                  emailController.text,
                                  pasController.text.trim(),
                                  context,
                                );
                                if (isSuccess) {
                                  provider.userData!.hotel != null
                                      ? Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.dashboard,
                                          (route) => false)
                                      : Navigator.pushNamed(
                                          context, Routes.addHotel);
                                }
                              }
                            },
                            buttonText: 'Sign In',
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
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.chooseLanguage,arguments: false),
                                child: Text(
                                  'CREATE ACCOUNT',
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
