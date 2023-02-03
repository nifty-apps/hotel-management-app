import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/services/local_strorage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      ref.read(localStorageProvider).loadTokenAndUser(),
      Future.delayed(const Duration(seconds: 1))
    ]).then((data) {
      print(data.first.last);
      if (data.first.first == null) {
        return Navigator.pushReplacementNamed(context, Routes.login);
      }
      if (data.first.last == null) {
        return Navigator.pushReplacementNamed(context, Routes.addHotel);
      } else {
        return Navigator.pushReplacementNamed(context, Routes.dashboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Image.asset(
                'assets/images/hotel.png',
                width: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Hotel Management System',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
