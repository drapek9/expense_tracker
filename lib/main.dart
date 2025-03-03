import 'package:flutter/material.dart';
import 'package:expense_tracker/home/home_main.dart';
import 'package:expense_tracker/spending_overview/spending_overview_main.dart';
import 'package:expense_tracker/loading_main.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home",
      routes: {
        "/loading": (context) => LoadingScreen(),
        "/home": (context) => HomeScreen(),
        "/spending_overview": (context) => SpendingOverviewScreen()
      },
    );
  }
}