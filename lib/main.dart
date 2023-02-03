import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/theme/theme.dart';
import 'package:hotel_management/view/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: HotelManagement()));
}

class HotelManagement extends StatelessWidget {
  const HotelManagement({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: Routes.onGenerateRoute,
      onUnknownRoute: ((settings) {
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      }),

      // home: FutureBuilder(
      //   future: Get.find<LocalStorage>().loadTokenAndUser(),
      //   builder: (context, AsyncSnapshot<List<dynamic>?> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.data == null) {
      //         return LoginScreen();
      //       }
      //       if (snapshot.data!.last.hotel == null) {
      //         return AddHotelScreen();
      //       } else {
      //         return DashboardScreen();
      //       }
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }
}
