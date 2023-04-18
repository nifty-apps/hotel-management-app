import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/hotel.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class AddHotelScreen extends ConsumerWidget {
  AddHotelScreen({Key? key}) : super(key: key);
  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController hotelAddressController = TextEditingController();
  final TextEditingController contactNumberConteroller =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(authProvider);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Image.asset(
                    'assets/images/hotel.png',
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Add Your Hotel & Manage Easily',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
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
                            CustomTextFormField(
                              controller: hotelNameController,
                              hintText: 'Enter hotel name',
                              labelText: 'Hotel Name',
                              prefixIcon: Icons.hotel,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter hotel name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextFormField(
                              controller: ownerNameController,
                              hintText: 'Enter hotel owner name',
                              labelText: 'Hotel Owner Name',
                              prefixIcon: Icons.person,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter hotel owner name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextFormField(
                              controller: hotelAddressController,
                              hintText: 'Enter hotel address',
                              labelText: 'Hotel Address',
                              prefixIcon: Icons.contact_page,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter hotel address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextFormField(
                              controller: contactNumberConteroller,
                              hintText: 'Enter contact number',
                              labelText: 'Contact Number',
                              prefixIcon: Icons.phone,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter contact number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 120),
                            CustomButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Hotel? hotel = await provider.addHotel(
                                    name: hotelNameController.text,
                                    ownerName: ownerNameController.text,
                                    address: hotelAddressController.text,
                                    contactNumber:
                                        contactNumberConteroller.text.trim(),
                                  );
                                  if (hotel?.id != null) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      Routes.dashboard,
                                    );
                                  }
                                }
                              },
                              buttonText: 'Submit',
                              width: double.infinity,
                              height: 48,
                            ),
                            SizedBox(height: 10)
                          ],
                        ),
                      ),
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
