import 'package:flutter/material.dart';
import 'package:ios_fl_n_antifish_3408/screens/navigation/navigation_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> _onboardingImages = List.generate(
    4,
    (index) => 'assets/images/onboarding/${index + 1}.png',
  );

  int _currentPageIndex = 0;

  void _goToNextPage() {
    if (_currentPageIndex < _onboardingImages.length - 1) {
      setState(() {
        _currentPageIndex++;
      });
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MenuScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _goToNextPage,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(_onboardingImages[_currentPageIndex], fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}
