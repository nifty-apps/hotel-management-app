import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';

class AddHotelScreen extends ConsumerWidget {
  AddHotelScreen({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressConteroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Hotel',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
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
                          onPressed: () async {
                            // Get.find<AuthController>().logout();
                            await provider.addHotel(
                              nameController.text.trim(),
                              addressConteroller.text.trim(),
                            );
                            Navigator.pushReplacementNamed(
                                context, Routes.login);
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
