import 'package:flutter/material.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';

class AddHotel extends StatelessWidget {
  AddHotel({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressConteroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                'assets/images/restaurant_info.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Password',
                      isPassword: true,
                    ),
                    CustomTextField(
                      controller: addressConteroller,
                      hintText: 'Password',
                      isPassword: true,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
