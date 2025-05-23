import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_antifish_3408/cubit/reminder_cubit/reminder_cubit.dart';
import 'package:ios_fl_n_antifish_3408/screens/loading_screen/loading_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor =
        Colors.transparent; // was color const Color(0xFF041123)
    return BlocProvider(
      create: (context) => ReminderCubit(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/main_background.png',
                  fit: BoxFit.cover,
                ),
              ),
              child ?? const SizedBox.shrink(),
            ],
          );
        },
        theme: ThemeData(
          scaffoldBackgroundColor: primaryColor,
          appBarTheme: AppBarTheme(backgroundColor: primaryColor),
        ),
        home: LoadingScreen(),
      ),
    );
  }
}
