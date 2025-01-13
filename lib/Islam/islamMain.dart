import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';  // Import GetX
import 'package:wa_business/Islam/home.dart';  // Your Home page
import 'package:timezone/data/latest.dart' as tz;

import 'navBar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Use GetMaterialApp instead of MaterialApp
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this to your desired color
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF43AD66), // Primary color
          primary: const Color(0xFF43AD66),
          secondary: const Color(0xFF43AD66), // Optionally set for accents
        ),
        scaffoldBackgroundColor: Colors.white, // Background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF43AD66), // AppBar color
          foregroundColor: Colors.white, // AppBar text/icon color
        ),
        useMaterial3: true, // Enable Material 3 styling
      ),
      home: const NavBar(),
    );
  }
}

// UCct5L-DaVYK8UtmqGU8gJtw