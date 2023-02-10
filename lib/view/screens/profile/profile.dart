import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/services/local_strorage.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/widgets/profile_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.read(authProvider).userData;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      Icons.house,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userData.hotel!.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    userData.hotel!.address,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  ProfileTile(
                    title: userData.name,
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: 15),
                  ProfileTile(
                    title: userData.role,
                    icon: Icons.badge_outlined,
                  ),
                  SizedBox(height: 15),
                  ProfileTile(
                    title: userData.email,
                    icon: Icons.email_outlined,
                  ),
                  SizedBox(height: 15),
                  ProfileTile(
                    title: 'Change Password',
                    icon: Icons.lock_outline,
                  ),
                  SizedBox(height: 15),
                  ProfileTile(
                    title: 'Update Profile',
                    icon: Icons.edit,
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => showLogoutDialog(context, ref));
                    },
                    child: Ink(
                      child: ProfileTile(
                        title: 'Logout',
                        icon: Icons.logout_outlined,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Version: 1.0.0',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showLogoutDialog(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/question.png',
              height: 32,
              width: 32,
            ),
            SizedBox(height: 20),
            Text(
              'Are you sure you want to logout?',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  buttonText: 'No',
                  width: 80,
                  height: 35,
                ),
                CustomButton(
                  onPressed: () async {
                    await ref.read(localStorageProvider).removeTokenAndUser();
                    Navigator.pushNamed(context, Routes.login);
                  },
                  buttonText: 'Yes',
                  width: 80,
                  height: 35,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
