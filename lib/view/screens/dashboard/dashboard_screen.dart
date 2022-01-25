import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:somudro_bilash_hotel/controller/auth_controller.dart';
import 'package:somudro_bilash_hotel/controller/reports_controller.dart';
import 'package:somudro_bilash_hotel/controller/room_type_controller.dart';
import 'package:somudro_bilash_hotel/controller/search_room_controller.dart';
import 'package:somudro_bilash_hotel/controller/transactionController.dart';
import 'package:somudro_bilash_hotel/view/screens/changePassword/changePassword_page.dart';
import 'package:somudro_bilash_hotel/view/screens/login_screen/login_page.dart';
import 'package:somudro_bilash_hotel/view/screens/revenue/revenue.dart';
import 'package:somudro_bilash_hotel/view/screens/transaction/transacionView_page.dart';
import 'package:somudro_bilash_hotel/view/widgets/dashboard/date_range.dart';
import 'package:somudro_bilash_hotel/view/widgets/dashboard/room_type_info_tile.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.find<SearchRoomController>().getAllRooms();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Text('Dashboard'),
          actions: [
            PopupMenuButton(
              onSelected: (value) async {
                switch (value) {
                  case 0:
                    Get.to(() => ChangePassPage());
                    break;
                  case 1:
                    Get.find<ReportController>().getReports();
                    Get.to(() => RevenuePage());
                    break;
                  case 2:
                    transactionDialog(context);
                    break;
                  case 3:
                    updatePayment(context);
                    break;
                  case 4:
                    logoutDialog(context);
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(width: 10.0),
                      Text('Change Password'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(width: 10.0),
                      Text('Revenue'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.payment_sharp,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(width: 10.0),
                      Text('Transaction history'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.update_sharp,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(width: 10.0),
                      Text('Update Payment'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 4,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(width: 10.0),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    DateRange(),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await Get.find<RoomTypeController>().getInfo();
                },
                icon: Icon(Icons.search),
                label: Text('Search'),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: GetBuilder<RoomTypeController>(builder: (controller) {
                    return controller.isLoading
                        ? Center(
                            child: SpinKitThreeBounce(
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.roomInfo.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RoomTypeInfoTile(
                                roomType:
                                    controller.roomInfo.keys.elementAt(index),
                                roomAvailable:
                                    controller.roomInfo.values.elementAt(index),
                              );
                            },
                          );
                  }),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ));
  }

  logoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Are you sure?',
          style: TextStyle(fontSize: 18),
        ),
        content: Text('Do you want to logout?',
            style: TextStyle(
              fontSize: 18,
            )),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () async {
                bool success = await Get.find<AuthController>().logout();
                if (success) Get.offAll(LoginPage());
                Get.snackbar('Logout', 'Logout successfuly!');
              },
              child: Text('Ok'))
        ],
      ),
    );
  }

  transactionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Form(
            key: formkey,
            child: Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller: idController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter booking ID';
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Booking ID',
                            errorStyle: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: 14.0,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 35)),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              Get.find<TransactionController>()
                                  .getTransactions(idController.text);
                              idController.clear();
                              Get.to(() => TransactionView());
                            }
                          },
                          child: Text('See Transaction'))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  updatePayment(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Form(
            key: formkey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: idController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter booking ID';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Booking ID',
                        errorStyle: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: amountController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter update amount';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Amount',
                        errorStyle: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(200, 35)),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          Get.offAll(() => DashboardScreen());
                          Get.snackbar('Update', 'Payment updated successfuly');
                        }
                      },
                      child: Text('Update'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
