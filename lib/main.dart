import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rabin_karp_algorithm_app/controller/about_controller.dart';
import 'package:flutter_rabin_karp_algorithm_app/controller/home_controller.dart';
import 'package:flutter_rabin_karp_algorithm_app/controller/splash_controller.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/splash/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => SplashController(),
            ),
            ChangeNotifierProvider(
              create: (context) => HomeController(),
            ),
            ChangeNotifierProvider(
              create: (context) => AboutController(),
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorManager.PRIMARY_COLOR,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: ColorManager.SECONDARY_COLOR,
          foregroundColor: ColorManager.WHITE,
          titleTextStyle: GoogleFonts.inter(
            color: ColorManager.WHITE,
            fontSize: UnitManager.DISPLAY_SIZE,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: const IconThemeData(
            color: ColorManager.WHITE,
            size: 30.0,
          ),
          actionsIconTheme: const IconThemeData(
            color: ColorManager.WHITE,
            size: 30.0,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
