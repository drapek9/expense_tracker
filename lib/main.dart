import 'package:flutter/material.dart';
import 'package:expense_tracker/home/home_main.dart';
import 'package:expense_tracker/spending_overview/spending_overview_main.dart';
import 'package:expense_tracker/loading_main.dart';
import 'package:expense_tracker/history/history_main.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/aha",
      routes: {
        "/loading": (context) => LoadingScreen(),
        "/home": (context) => HomeScreen(),
        "/spending_overview": (context) => SpendingOverviewScreen(),
        "/history": (context) => HistoryScreen(),
        "/aha": (context) => MainSwitchScreens()
      },
    );
  }
}

class MainSwitchScreens extends StatefulWidget {
  const MainSwitchScreens({super.key});

  @override
  State<MainSwitchScreens> createState() => _MainSwitchScreensState();
}

class _MainSwitchScreensState extends State<MainSwitchScreens> {
  PageController pageController = PageController(initialPage: 1);
  int selectedIndex = 1;

  void bottomButtonTapped(int theIndex) {
    setState(() {
      selectedIndex = theIndex;
    });
    print(theIndex.toDouble());
    pageController.animateToPage(
      theIndex,
      duration: Duration(milliseconds: 50),  // Nastavujeme rychlost animace
      curve: Curves.ease,  // Typ animace
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          HistoryScreen(),
          HomeScreen(),
          SpendingOverviewScreen()

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: bottomButtonTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Overview")
        ]
        ),
    );
  }
}