import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/response_message.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final String email;
  ForgotPasswordScreen({super.key, required this.email});
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Consumer(builder: (context, ref, _) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                    isPassword: true,
                    controller: passwordController,
                    hintText: 'Enter new password',
                    labelText: 'Password',
                    prefixIcon: Icons.password,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    }),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Consumer(builder: (context, ref, _) {
        final provider = ref.watch(authProvider);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SizedBox(
            height: 45,
            child: CustomButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ResponseMessage responseMessage =
                      await provider.changePassword(
                    email: email,
                    newPassword: passwordController.text.trim(),
                  );
                  showSnackBarMethod(context, responseMessage.message,
                      responseMessage.isSuccess);
                  if (responseMessage.isSuccess) {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  }
                }
              },
              buttonText: 'Change Password',
              width: double.infinity,
            ),
          ),
        );
      }),
    );
  }
}
