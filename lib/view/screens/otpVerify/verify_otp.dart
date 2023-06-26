import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/response_message.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final bool isSingUp;
  VerifyOTPScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.isSingUp,
  });

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController pinCodeController = TextEditingController();
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_secondsRemaining < 1) {
          timer.cancel();
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.email);
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final provider = ref.read(authProvider);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Code has sent to'),
                Text(
                  widget.email,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.white,
                      inactiveFillColor: Colors.grey.shade500,
                      inactiveColor: Colors.grey.shade400,
                      selectedFillColor: Colors.white,
                      selectedColor: Colors.white,
                      borderWidth: 0,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: pinCodeController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {});
                    },
                    onCompleted: (v) {},
                  ),
                ),
                SizedBox(height: 50),
                Text("Haven't received the verification code?"),
                SizedBox(height: 5),
                _secondsRemaining != 0
                    ? Text(
                        _secondsRemaining.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          setState(() {
                            _secondsRemaining = 60;
                          });
                          pinCodeController.clear();
                          ResponseMessage result =
                              await provider.sendOtp(email: widget.email);
                          showSnackBarMethod(
                            context,
                            result.message,
                            result.isSuccess,
                          );

                          startTimer();
                        },
                        child: Text(
                          'Resend Code',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                SizedBox(height: 50),
                pinCodeController.text.length != 6
                    ? SizedBox()
                    : provider.isLoading
                        ? CircularProgressIndicator()
                        : CustomButton(
                            onPressed: () async {
                              ResponseMessage otpResult =
                                  await provider.verifyOTP(
                                email: widget.email,
                                code: pinCodeController.text.trim(),
                              );
                              if (otpResult.isSuccess == false) {
                                showSnackBarMethod(
                                  context,
                                  otpResult.message,
                                  otpResult.isSuccess,
                                );
                              } else {
                                ResponseMessage registraionResult =
                                    await provider.registration(
                                  fullName: widget.name,
                                  email: widget.email,
                                  password: widget.password,
                                );
                                showSnackBarMethod(
                                    context,
                                    registraionResult.message,
                                    registraionResult.isSuccess);
                                if (registraionResult.isSuccess) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.addHotel,
                                  );
                                }
                              }
                            },
                            buttonText: 'Verify',
                            radius: 6,
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
