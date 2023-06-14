import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/provider/employee.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/services/local_strorage.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.read(authProvider).userData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Info'),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.all(
          20,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/man.png',
              width: 80,
            ),
            Text(
              userData!.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 80),
              child: Row(
                children: [
                  Icon(Icons.email_outlined),
                  SizedBox(width: 10),
                  Text(ref.read(authProvider).userData!.email),
                ],
              ),
            ),
            SizedBox(height: 10),
            userData.role == 'Owner'
                ? Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Row(
                      children: [
                        Icon(Icons.account_box_outlined),
                        SizedBox(width: 10),
                        Text(ref.read(authProvider).userData!.role.toString()),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Row(
                      children: [
                        Icon(Icons.phone_outlined),
                        SizedBox(width: 10),
                        Text(ref.read(authProvider).userData!.phone.toString()),
                      ],
                    ),
                  ),
            SizedBox(height: 10),
            userData.role == 'Owner'
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 10),
                        Text(ref.read(authProvider).userData!.hotel!.address),
                      ],
                    ),
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: userData.role == 'Owner'
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                height: 45,
                child: ref.watch(employeeProvider).isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton.icon(
                        onPressed: () async {
                          bool isSuccess = await ref
                              .read(employeeProvider)
                              .deleteAccount(id: userData.id, context: context);
                          if (isSuccess) {
                            await ref
                                .read(localStorageProvider)
                                .removeTokenAndUser();
                            Navigator.pushNamed(context, Routes.login);
                          }
                        },
                        icon: Icon(Icons.delete),
                        label: Text('Delete Account'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
              ),
            )
          : SizedBox(),
    );
  }
}
