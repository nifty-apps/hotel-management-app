// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/provider/room_type.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_dialog.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class AddRoomTypeScreen extends ConsumerWidget {
  final RoomType roomType;
  AddRoomTypeScreen({
    Key? key,
    required this.roomType,
  }) : super(key: key);

  final TextEditingController typeController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void setinfo() {
    typeController.text = roomType.room.toString();
    rentController.text = roomType.rent.toString();
    descriptionController.text = roomType.description!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (roomType.id!.isNotEmpty) {
      setinfo();
    }
    setinfo();
    final provider = ref.read(roomTypeProvider);
    return Scaffold(
      appBar: AppBar(
        title:
            Text(roomType.id!.isNotEmpty ? 'Edit Room type' : 'Add Room Type'),
        actions: [
          roomType.id!.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    provider.deleteRoomType(roomType.id.toString(), context);
                    Navigator.pop(context, true);
                  },
                  icon: Icon(Icons.delete),
                )
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: typeController,
                hintText: 'Room type',
                labelText: 'Room Type',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter room type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              CustomTextFormField(
                controller: rentController,
                hintText: 'rent',
                labelText: 'rent',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter rent';
                  }
                  return null;
                },
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    late bool isSuccess;
                    if (roomType.id!.isNotEmpty) {
                      isSuccess = await provider.updateRoomType(
                          roomType.id.toString(),
                          context,
                          typeController.text,
                          int.parse(rentController.text),
                          descriptionController.text);
                    } else {
                      isSuccess = await provider.addRoomType(
                        typeController.text,
                        int.parse(rentController.text),
                        descriptionController.text,
                        context,
                      );
                    }

                    if (isSuccess) {
                      Navigator.pop(context, true);
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: roomType.id!.isNotEmpty
                              ? 'The room type has been updated successfully!'
                              : 'The room type has been added successfully !',
                          buttonText: 'Back',
                          imagePath: 'assets/icons/successful.png',
                          onTap: () {
                            Navigator.pop(context, true);
                          },
                        ),
                      );
                    }
                  }
                },
                buttonText:
                    roomType.id!.isNotEmpty ? 'Update' : 'Add Room Type',
              )
            ],
          ),
        ),
      ),
    );
  }
}
