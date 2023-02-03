import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';

class AddRoomScreen extends ConsumerWidget {
  AddRoomScreen({Key? key}) : super(key: key);
  final TextEditingController floorController = TextEditingController();
  final TextEditingController roomConteroller = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController rentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                'Add Room',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('assets/images/living_room.png'),
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
                          isNumber: true,
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
                        CustomButton(
                          onPressed: () {},
                          buttonText: 'Submit',
                          width: double.infinity,
                          height: 48,
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
