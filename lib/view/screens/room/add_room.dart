// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/provider/room.dart';
import 'package:hotel_management/provider/room_type.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class AddRoomScreen extends ConsumerStatefulWidget {
  final Room roomData;
  AddRoomScreen({
    Key? key,
    required this.roomData,
  }) : super(key: key);
  @override
  ConsumerState<AddRoomScreen> createState() => _AddRoomScreenState();
}

final TextEditingController numbercontroller = TextEditingController();
final TextEditingController typeController = TextEditingController();
final TextEditingController rentConteroller = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

class _AddRoomScreenState extends ConsumerState<AddRoomScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String roomTypeId;

  @override
  void initState() {
    setUpdateInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomData.id != null ? 'Edit Room' : 'Add New Room'),
        automaticallyImplyLeading: true,
        actions: [
          if (provider.userData!.role == 'Owner')
            if (widget.roomData.id != null)
              IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await ref
                      .read(roomProvider)
                      .deleteRoom(widget.roomData.id.toString(), context);
                  await ref.read(roomProvider).getRoomList(null);
                },
                icon: Icon(Icons.delete),
              ),
        ],
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: numbercontroller,
                  hintText: 'Room number',
                  labelText: 'Room number',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter room number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  controller: typeController,
                  hintText: 'Type',
                  labelText: 'Type',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  isSuffixIcon: true,
                  suffixButtonAction: () async {
                    showDialog(
                      context: context,
                      builder: (context) => roomTypeDialog(context),
                    );
                  },
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  controller: rentConteroller,
                  hintText: 'Rent',
                  labelText: 'Rent',
                  keyboardType: TextInputType.number,
                  readOnly: true,
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: 'Description',
                  labelText: 'Description',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                ),
                Spacer(),
                CustomButton(
                  width: double.infinity,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.roomData.id != null) {
                        await ref.read(roomProvider).updateRoomInfo(
                            numbercontroller.text.trim(),
                            roomTypeId,
                            widget.roomData.id.toString(),
                            context);
                        ref.read(roomProvider).getRoomList(null);
                        clearData();
                      } else {
                        await ref.read(roomProvider).addRoom(
                              numbercontroller.text.trim(),
                              roomTypeId,
                              context,
                            );
                        clearData();
                        ref.read(roomProvider).getRoomList(null);
                      }
                    }
                    Navigator.pop(context);
                  },
                  buttonText:
                      widget.roomData.id != null ? 'Update' : 'Add Room ',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget roomTypeDialog(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder(
          future: ref.read(roomTypeProvider).getRoomTypeList(),
          builder: (context, AsyncSnapshot<List<RoomType>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<RoomType> roomType = snapshot.data ?? [];
              if (roomType.length == 0) {
                return Center(
                  child: Text('No room type found!'),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Room Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: roomType.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Divider(
                              color: Theme.of(context).colorScheme.background,
                              thickness: 3,
                            ),
                            ListTile(
                              title: Text(roomType[index].type.toString()),
                              onTap: () {
                                setState(() {
                                  typeController.text =
                                      roomType[index].type.toString();
                                  rentConteroller.text =
                                      roomType[index].rent.toString();
                                  descriptionController.text =
                                      roomType[index].description.toString();
                                  roomTypeId = roomType[index].id.toString();
                                });
                                Navigator.pop(context);
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.green,
                                child: Text(
                                  index.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void setUpdateInfo() {
    if (widget.roomData.id != null) {
      print('data is not null');
      setState(() {
        numbercontroller.text = widget.roomData.number.toString();
        typeController.text = widget.roomData.roomType!.type.toString();
        rentConteroller.text = widget.roomData.roomType!.rent.toString();
        descriptionController.text =
            widget.roomData.roomType!.description.toString();
        roomTypeId = widget.roomData.roomType!.id.toString();
      });
    } else {
      print('data is null');
      clearData();
    }
  }

  void clearData() {
    numbercontroller.clear();
    typeController.clear();
    rentConteroller.clear();
    descriptionController.clear();
    roomTypeId = '';
  }
}
