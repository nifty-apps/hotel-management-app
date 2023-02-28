import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/theme/theme.dart';
import 'package:hotel_management/translations/codegen_loader.g.dart';
import 'package:hotel_management/view/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('bn')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        assetLoader: CodegenLoader(),
        child: HotelManagement(),
      ),
    ),
  );
}

class HotelManagement extends StatelessWidget {
  const HotelManagement({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: Routes.onGenerateRoute,
      onUnknownRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      }),
    );
  }
}
