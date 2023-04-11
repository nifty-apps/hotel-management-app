import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ref.read(authProvider).userData!.name,
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
            ref.read(authProvider).userData!.role == 'Owner'
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
            ref.read(authProvider).userData!.role == 'Owner'
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
    );
  }
}
