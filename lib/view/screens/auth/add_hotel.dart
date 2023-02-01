import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_management/controller/auth_controller.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';
import 'package:hotel_management/view/screens/dashboard/dashboard_screen.dart';

class AddHotel extends StatelessWidget {
  AddHotel({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressConteroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Add Hotel',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                SizedBox(height: 10),
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/hotel.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 50),
                Flexible(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          hintText: 'Name',
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: addressConteroller,
                          hintText: 'Address',
                        ),
                        SizedBox(height: 30),
                        CustomButton(
                          onPressed: () {
                            // Get.find<AuthController>().logout();
                            Get.find<AuthController>()
                                .addHotel(
                              nameController.text.trim(),
                              addressConteroller.text.trim(),
                            )
                                .then((hotel) {
                              if (hotel?.id != null) {
                                print(hotel);
                                Get.to(
                                  () => DashboardScreen(),
                                  transition: Transition.fadeIn,
                                );
                              }
                            });
                          },
                          buttonText: 'Submit',
                          width: double.infinity,
                          height: 48,
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
