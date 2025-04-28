import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ios_fl_n_antifish_3408/screens/navigation/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ios_fl_n_antifish_3408/screens/onboarding_screen/onboarding_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    Timer(const Duration(seconds: 2), () {
      if (hasSeenOnboarding) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MenuScreen()),
        );
      } else {
        prefs.setBool('hasSeenOnboarding', true);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/load_screen.png', fit: BoxFit.fill),
        ],
      ),
    );
  }
}
