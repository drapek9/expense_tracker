import 'package:flutter/material.dart';
import 'package:expense_tracker/classes_types/classes_types_main.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  // const HistoryScreen({super.key});

  final List allExpenses = [
      Expense(
        category: 1,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 1,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 1,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 1,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 1,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 1,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 1,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 1,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
  ];

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemCount: widget.allExpenses.length,
          itemBuilder: (context, index){
            Expense theWidget = widget.allExpenses[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 7.5),
              child: SizedBox(
                height: 100,
                child: Card(
                  color: const Color.fromARGB(255, 242, 242, 242),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 6),
                    child: Column(
                      spacing: 5,
                      children: [
                        Text(
                          DateFormat("dd MMMM yyyy HH:mm").format(theWidget.time!),
                          style: TextStyle(
                            color: const Color.fromARGB(255, 94, 94, 94),
                            fontSize: 11
                          ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${theWidget.name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                  ),
                                ),
                                Text(
                                  "${theWidget.categoryOptions[theWidget.category]}",
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 128, 128, 128),
                                    fontSize: 12
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "-${theWidget.prize} ${theWidget.currencyOptions[theWidget.currency]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          ),
      ),
    );
  }
}