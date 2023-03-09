import 'package:flutter/material.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/intro.png'),
            SizedBox(height: 10),
            Text(
              'Welcome ',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 10),
            Text(
              'Your Hotel Management Solution Starts Here',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              welcomeText,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 75),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.signUp);
              },
              buttonText: "Let's Go",
              width: 288,
            )
          ],
        ),
      ),
    ));
  }

  static const String welcomeText =
      'Welcome to our admin app, designed to simplify your hotel booking management. From reservations to check-ins and checkouts, our app has everything you need to keep your business running smoothly.';
}
