import 'package:flutter/material.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/view/base/date_picker_button.dart';
import 'package:hotel_management/view/base/search_button.dart';
import 'package:hotel_management/view/base/search_text_form_field.dart';

class CheckinScreen extends StatefulWidget {
  CheckinScreen({super.key});
  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  final TextEditingController searchController = TextEditingController();
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkin'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: [
                        // SearchTextFormField(
                        //   controller: searchController,
                        //   hintText: 'Enter booking name or number',
                        //   onEditingComplete: () {},
                        // ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'From Date',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      InkWell(
                                          onTap: () async {
                                            final date =
                                                await selectDate(context);
                                            setState(() {
                                              fromDate = date;
                                            });
                                          },
                                          child:
                                              DatePickerButton(date: fromDate)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 14),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'To Date',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      InkWell(
                                        onTap: () async {
                                          final date =
                                              await selectDate(context);
                                          setState(() {
                                            toDate = date;
                                          });
                                        },
                                        child: DatePickerButton(date: toDate),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Flexible(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            'Checkin List',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Divider(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  thickness: 3,
                                ),
                                ListTile(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.choiceRooms,
                                    arguments: false,
                                  ),
                                  leading: Icon(Icons.person),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  title: Text('Abu Taher Molla'),
                                  subtitle: Text('0172653987'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 245,
            child: SearchButton(
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
