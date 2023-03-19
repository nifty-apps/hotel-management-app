// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class AddRoomScreen extends ConsumerWidget {
  final bool isUpdate;

  AddRoomScreen({
    Key? key,
    required this.isUpdate,
  }) : super(key: key);

  final TextEditingController numbercontroller = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController rentConteroller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // void setUpdateInfo() {
  //   if (isUpdate) {
  //     floorController.text = roomData?.floor ?? '';
  //     roomConteroller.text = roomData?.number ?? '';
  //     typeController.text = roomData?.roomType ?? '';
  //     rentController.text = roomData?.rent.toString() ?? '';
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Edit Room' : 'Add New Room'),
        automaticallyImplyLeading: true,
      ),
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: Container(
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
                controller: numbercontroller,
                hintText: 'Room number',
                labelText: 'Room number',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 30),
              CustomTextFormField(
                controller: typeController,
                hintText: 'Type',
                labelText: 'Type',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 30),
              CustomTextFormField(
                controller: rentConteroller,
                hintText: 'Rent',
                labelText: 'Rent',
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
                          ? 'The room has been successfully updated!'
                          : 'The room has been successfully added!',
                      buttonText: 'Back',
                      imagePath: 'assets/icons/successful.png',
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.pushNamed(
                        //   context,
                        //   Routes.roomList,
                        //   arguments: false,
                        // );
                      },
                    ),
                  );
                },
                buttonText: isUpdate ? 'Update' : 'Add Room ',
              )
            ],
          ),
        ),
      ),
    );
  }
}
