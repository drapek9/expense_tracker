import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expense_tracker/classes_types/classes_types_main.dart';

class SpendingOverviewScreen extends StatefulWidget {
  // const SpendingOverviewScreen({super.key});


  @override
  State<SpendingOverviewScreen> createState() => _SpendingOverviewScreenState();
}

class _SpendingOverviewScreenState extends State<SpendingOverviewScreen> {
  final List allExpenses = [
      Expense(
        category: 2,
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
        category: 0,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 2,
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
        category: 3,
        currency: 1,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
  ];

  Map<String, Map> sumExpensesCategory = {};

  int xNum = -1;
  Map xNumValue = {};

  @override
  void initState() {
    super.initState();
    sumExpensesCategory = createSumCategory(allExpenses);
  }

  Map<String, Map> createSumCategory(List theExpenses){
    Map<String, Map> theSumExpenses = {"category": {}};

    theExpenses.forEach((one){
      print(one);
      if (theSumExpenses["category"]!.keys.toList().contains(one.categoryOptions[one.category])){
        theSumExpenses["category"]![one.categoryOptions[one.category]]["prize"] += one.prize;
      } else {
        theSumExpenses["category"]![one.categoryOptions[one.category]] = {
          "prize": one.prize
          
        };
      }
    });

    return theSumExpenses;

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                // titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: sumExpensesCategory["category"]!.entries.map((one) {
                  xNum ++;
                  xNumValue[xNum] = one;
                  return BarChartGroupData(x: xNum, barRods: [BarChartRodData(toY: one.value["prize"].toDouble(), color: Colors.blue, width: 50, borderRadius: BorderRadius.all(Radius.circular(12)))]);
                }).toList(),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)
                  ),
                  bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(xNumValue[value].key);
                  },
                ),
              ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        "${xNumValue[value].value["prize"]}",
                        style: TextStyle(
                          color: Colors.black
                        ),
                        );
                    }
                  )
                )
                ),
            )),
          ),
        ],
      ),
    );
  }
}