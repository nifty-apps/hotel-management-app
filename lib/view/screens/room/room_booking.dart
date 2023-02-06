import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/date_picker.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/custom_text_field.dart';

class RoomBooking extends ConsumerStatefulWidget {
  final String roomId;
  final bool isUpdate;

  RoomBooking({Key? key, required this.roomId, required this.isUpdate})
      : super(key: key);

  @override
  ConsumerState<RoomBooking> createState() => _RoomBookingState();
}

class _RoomBookingState extends ConsumerState<RoomBooking> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController rentController = TextEditingController();

  String checkInDate = 'CheckIn';
  String checkOutDate = 'CheckOut';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 220,
              title: Text(
                'Add Room',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Image.asset(
                    'assets/images/booking.png',
                  ),
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
                          controller: nameController,
                          inputType: TextInputType.text,
                          hintText: 'Floor',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: addressController,
                          inputType: TextInputType.text,
                          hintText: 'Room ',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: phoneController,
                          hintText: 'Type',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          controller: rentController,
                          hintText: 'Rent',
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () {
                                  selectDate(context).then((pickedDate) {
                                    setState(() {
                                      checkInDate = pickedDate!;
                                    });
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).hoverColor),
                                  height: 54,
                                  child: Center(
                                    child: Text(checkInDate),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  selectDate(context).then((pickedDate) {
                                    setState(() {
                                      checkOutDate = pickedDate!;
                                    });
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).hoverColor,
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  height: 54,
                                  child: Center(
                                    child: Text(checkOutDate),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          onPressed: () {},
                          buttonText: 'Submit',
                          height: 48,
                          width: double.infinity,
                        )
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
