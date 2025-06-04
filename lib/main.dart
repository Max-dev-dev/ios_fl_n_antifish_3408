import 'package:flutter/material.dart';
import 'package:ios_fl_n_antifish_3408/app.dart';
import 'package:ios_fl_n_antifish_3408/ver_screen.dart';

class AppConstants {
  static const String oneSignalAppId = "71aa15d4-0077-42c1-9870-80977f7e14ad";
  static const String appsFlyerDevKey = "v7xCW2oiGJ5JauPXwWiS5W";
  static const String appID = "6745167381";

  static const String baseDomain = "astonishing-notable-triumphant.space";
  static const String verificationParam = "ekdi82nX";

  static const String splashImagePath = 'assets/images/l1.png';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final now = DateTime.now();
  final dateOff = DateTime(2024, 6, 6, 20, 00);

  final initialRoute = now.isBefore(dateOff) ? '/white' : '/verify';
  runApp(RootApp(
    initialRoute: initialRoute,
    whiteScreen: MainApp(),
  ));
}

