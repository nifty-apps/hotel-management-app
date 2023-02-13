// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/add_room.dart';
import 'package:hotel_management/models/room.dart';
import 'package:hotel_management/models/user.dart';
import 'package:hotel_management/provider/room.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/services/local_strorage.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';

class AddRoomScreen extends ConsumerWidget {
  final bool isUpdate;
  final Room? roomData;

  AddRoomScreen({
    Key? key,
    required this.isUpdate,
    this.roomData,
  }) : super(key: key);

  final TextEditingController floorController = TextEditingController();
  final TextEditingController roomConteroller = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController rentController = TextEditingController();

  void setUpdateInfo() {
    if (isUpdate) {
      floorController.text = roomData?.floor ?? '';
      roomConteroller.text = roomData?.number ?? '';
      typeController.text = roomData?.roomType ?? '';
      rentController.text = roomData?.rent.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(isUpdate);
    setUpdateInfo();
    return Scaffold(
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 300,
              title: Text(
                isUpdate ? 'Update Room' : 'Add Room',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Image.asset('assets/images/living_room.png'),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: floorController,
                          inputType: TextInputType.text,
                          hintText: 'Floor',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: roomConteroller,
                          inputType: TextInputType.text,
                          hintText: 'Room ',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: typeController,
                          hintText: 'Type',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: rentController,
                          inputType: TextInputType.number,
                          isNumber: true,
                          hintText: 'Rent',
                        ),
                        SizedBox(height: 16),
                        FutureBuilder(
                          future:
                              ref.read(localStorageProvider).getCurrentUser(),
                          builder: (context, AsyncSnapshot<User?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final User? userInfo = snapshot.data;
                              if (userInfo == null) {
                                return Center(
                                  child: Text('Something went wrong'),
                                );
                              }
                              return CustomButton(
                                onPressed: () async {
                                  AddRoom room = AddRoom(
                                    floor: floorController.text.trim(),
                                    number: roomConteroller.text.trim(),
                                    type: typeController.text.trim(),
                                    rent: int.tryParse(rentController.text),
                                  );
                                  if (floorController.text.isEmpty ||
                                      roomConteroller.text.isEmpty ||
                                      typeController.text.isEmpty ||
                                      rentController.text.isEmpty) {
                                    showSnackBarMethod(
                                      context,
                                      'All fields are required!',
                                      false,
                                    );
                                  } else {
                                    if (isUpdate) {
                                      bool isSuccess = await ref
                                          .read(roomProvider)
                                          .updateRoomInfo(roomData?.id ?? '',
                                              room, context);
                                      if (isSuccess) {
                                        Navigator.pushNamed(
                                            context, Routes.dashboard);
                                      }
                                    } else {
                                      bool isSuccess = await ref
                                          .read(roomProvider)
                                          .addRoom(room, userInfo.hotel!.id,
                                              context);
                                      if (isSuccess) {
                                        Navigator.pushNamed(
                                            context, Routes.dashboard);
                                      }
                                    }
                                  }
                                },
                                buttonText: isUpdate ? 'Update' : 'Submit',
                                width: double.infinity,
                                height: 48,
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
