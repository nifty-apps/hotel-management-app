import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hotel_management/controller/auth_controller.dart';
import 'package:hotel_management/controller/payment_update_controller.dart';
import 'package:hotel_management/controller/reports_controller.dart';
import 'package:hotel_management/controller/room_type_controller.dart';
import 'package:hotel_management/controller/room_controller.dart';
import 'package:hotel_management/view/screens/admin_profile.dart/admin_profile_page.dart';
import 'package:hotel_management/view/screens/auth/login.dart';
import 'package:hotel_management/view/screens/revenue/revenue.dart';
import 'package:hotel_management/view/screens/transaction/transacion_view_page.dart';
import 'package:hotel_management/view/widgets/dashboard/room_type_info_tile.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final DateRangePickerController _controller = DateRangePickerController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  Get.to(() => AdminProfile());
                  break;
                case 1:
                  // Get.find<ReportController>().getReports();
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
                      Icons.person,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(width: 10.0),
                    Text('Profile'),
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
                      Icons.history,
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
                      Icons.add,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(width: 10.0),
                    Text('Add Payment'),
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
            Center(
              child: Text(
                'Select Date',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            SfDateRangePicker(
              controller: _controller,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                // Get.find<RoomController>().fromDate = args.value.startDate;
                // Get.find<RoomController>().toDate =
                //     args.value.endDate ?? args.value.startDate;
              },
              allowViewNavigation: false,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                // await Get.find<RoomTypeController>().getInfo(
                //   Get.find<RoomController>().fromDate,
                //   Get.find<RoomController>().toDate,
                // );
              },
              icon: Icon(Icons.search),
              label: Text('Search'),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child:  ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return RoomTypeInfoTile(
                          
                              );
                            },
                          
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                Get.snackbar('Logout', 'Logout successfuly!',
                    snackPosition: SnackPosition.BOTTOM);
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
                          minimumSize: Size(200, 35),
                        ),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            Get.back();
                            await Get.to(
                              () => TransactionView(
                                bookingId: int.parse(idController.text),
                              ),
                            );
                            idController.clear();
                          }
                        },
                        child: Text('See Transaction'),
                      )
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
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          // Get.find<PaymentUpdateController>().isLoading
                          //     ? Center(
                          //         child: SpinKitThreeBounce(
                          //           color: Theme.of(context).primaryColor,
                          //           size: 30,
                          //         ),
                          //       )
                          //     : Get.find<PaymentUpdateController>()
                          //         .paymentUpdate(
                          //             idController.text, amountController.text);
                          // Get.offAll(() => DashboardScreen());
                        }
                      },
                      child: Text('Add'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
