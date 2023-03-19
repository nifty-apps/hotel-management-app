// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class AddRoomTypeScreen extends StatelessWidget {
  final bool isUpdate;
  AddRoomTypeScreen({
    Key? key,
    required this.isUpdate,
  }) : super(key: key);
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Edit Room type' : 'Add Room Type'),
        actions: [
          isUpdate
              ? IconButton(onPressed: () {}, icon: Icon(Icons.delete))
              : SizedBox(),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          children: [
            CustomTextFormField(
              controller: typeController,
              hintText: 'Room type',
              labelText: 'Room Type',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 30),
            CustomTextFormField(
              controller: priceController,
              hintText: 'Price',
              labelText: 'Price',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            CustomTextFormField(
              controller: descriptionController,
              hintText: 'Description',
              labelText: 'Description',
              keyboardType: TextInputType.text,
            ),
            Spacer(),
            CustomButton(
              width: double.infinity,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: isUpdate
                        ? 'The room type has been successfully updated!'
                        : 'The room type has been successfully added!',
                    buttonText: 'Back',
                    imagePath: 'assets/icons/successful.png',
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.roomTypeList, (route) => false);
                    },
                  ),
                );
              },
              buttonText: isUpdate ? 'Update' : 'Add Room Type',
            )
          ],
        ),
      ),
    );
  }
}
