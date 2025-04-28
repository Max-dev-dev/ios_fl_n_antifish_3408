import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_fl_n_antifish_3408/screens/password_generator_screen/password_generator_screen.dart';
import 'package:ios_fl_n_antifish_3408/screens/quiz_screen/quiz_preview_screen.dart';
import 'package:ios_fl_n_antifish_3408/screens/reminder_screen/reminder_list_screen.dart';
import 'package:ios_fl_n_antifish_3408/screens/reminder_screen/reminder_screen.dart';
import 'package:ios_fl_n_antifish_3408/screens/settings_screen/settings_screen.dart';
import 'package:ios_fl_n_antifish_3408/screens/tips_screen/tips_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 2;

  final List<IconData> _icons = [
    FontAwesomeIcons.book,
    FontAwesomeIcons.bell,
    FontAwesomeIcons.circleQuestion,
  ];

  final List<Widget> _screens = [
    PasswordGeneratorScreen(),
    TipsScreen(),
    ReminderListScreen(),
    QuizPreviewScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double bottomPadding = screenWidth > 375 ? 50 : 10;

    return Scaffold(
      backgroundColor: const Color(0xFF0B172A),
      body: Stack(
        children: [
          IndexedStack(index: _selectedIndex, children: _screens),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _menuTabIcon(icon: FontAwesomeIcons.key, index: 0),
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 110,
                  height: 110,
                ),
                _menuTabIcon(
                  icon: FontAwesomeIcons.gear,
                  index: 4,
                ),
              ],
            ),
          ),

          // Bottom nav
          Positioned(
            bottom: bottomPadding,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B172A),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 0.6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_icons.length, (i) {
                    final actualIndex = i + 1;
                    final isActive = _selectedIndex == actualIndex;
                    return GestureDetector(
                      onTap: () => _onItemTapped(actualIndex),
                      child: Container(
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color:
                              isActive
                                  ? const Color(0xFFFF6A00)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white, width: 0.5),
                        ),
                        child: Icon(_icons[i], color: Colors.white, size: 28),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuTabIcon({required IconData icon, required int index}) {
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: isActive ? const Color(0xFFFF6A00) : Colors.transparent,
          border: Border.all(color: Colors.white),
        ),
        child: FaIcon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}
