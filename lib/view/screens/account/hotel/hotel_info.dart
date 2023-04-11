import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class HotelInfoScreen extends ConsumerStatefulWidget {
  const HotelInfoScreen({super.key});

  @override
  ConsumerState<HotelInfoScreen> createState() => _HotelInfoScreenState();
}

class _HotelInfoScreenState extends ConsumerState<HotelInfoScreen> {
  @override
  void initState() {
    super.initState();
    nameController.text = ref.read(authProvider).userData!.hotel!.name;
    ownerNameController.text =
        ref.read(authProvider).userData!.hotel!.ownerName;
    phoneController.text =
        ref.read(authProvider).userData!.hotel!.contactNumber;
    addressController.text = ref.read(authProvider).userData!.hotel!.address;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Hotel Info'),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 100,
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          children: [
            CustomTextFormField(
              controller: nameController,
              labelText: 'Hotel Name',
              hintText: 'Hotel Name',
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: ownerNameController,
              labelText: 'Hotel Owner Name',
              hintText: 'Name',
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: phoneController,
              labelText: 'Contatct Number',
              hintText: 'Number',
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: addressController,
              labelText: 'Hotel Address',
              hintText: 'Address',
              keyboardType: TextInputType.name,
            ),
            Spacer(),
            CustomButton(
              width: double.infinity,
              onPressed: () {
                
              },
              buttonText: 'Save',
            )
          ],
        ),
      ),
    );
  }
}
