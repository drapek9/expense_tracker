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
        currency: 0,
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
        currency: 2,
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
        currency: 0,
        name: "Shoes",
        prize: 15,
        time: DateTime(2024, 12, 10, 12, 51)
      ),
      Expense(
        category: 1,
        currency: 2,
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

  List graphColors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.brown, Colors.black];

  Map<String, Map> sumExpensesCategory = {};

  int xNum = -1;
  Map xNumValue = {};
  int xNum2 = -1;

  @override
  void initState() {
    super.initState();
    sumExpensesCategory = createSumCategory(allExpenses);
  }

  Map<String, Map> createSumCategory(List theExpenses){
    Map<String, Map> theSumExpenses = {"category": {}, "currency": {}};

    theExpenses.forEach((one){
      if (theSumExpenses["category"]!.keys.toList().contains(one.categoryOptions[one.category])){
        theSumExpenses["category"]![one.categoryOptions[one.category]]["prize_value"] += one.finalPrizeValue;
      } else {
        theSumExpenses["category"]![one.categoryOptions[one.category]] = {
          "prize_value": one.finalPrizeValue
          
        };
      }

      if (theSumExpenses["currency"]!.keys.toList().contains(one.currencyOptions[one.currency])){
        theSumExpenses["currency"]![one.currencyOptions[one.currency]]["prize_currency"] += one.prize;
        theSumExpenses["currency"]![one.currencyOptions[one.currency]]["prize_currency_value"] += one.finalPrizeValue;
      } else {
        theSumExpenses["currency"]![one.currencyOptions[one.currency]] = {
          "prize_currency": one.prize,
          "prize_currency_value": one.finalPrizeValue,
        };
      }

    });

    return theSumExpenses;

  }

  @override
  Widget build(BuildContext context) {
    xNum = -1;
    xNum2 = -1;
    xNumValue = {};
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              spacing: 20,
              children: [
                Text(
                  "Spendings by category",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: BarChart(
                    BarChartData(
                      // titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      barGroups: sumExpensesCategory["category"]!.entries.map((one) {
                        xNum ++;
                        xNumValue[xNum] = one;
                        return BarChartGroupData(x: xNum, barRods: [BarChartRodData(toY: one.value["prize_value"].toDouble(), color: graphColors[xNum], width: 30, borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)))]);
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
                          return SizedBox(
                            width: 75,
                            child: Center(
                              child: Text(
                                // softWrap: true,
                                xNumValue[value].key,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10
                                ),
                                ),
                            ),
                          );
                        },
                      ),
                    ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              "${xNumValue[value].value["prize_value"]} EUR",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold
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
          Column(
            spacing: 20,
            children: [
              Text(
                "Spendings by currency ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                  )),
              SizedBox(
                height: 150,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 0,
                    sections: sumExpensesCategory["currency"]!.entries.map((one){
                      xNum2 ++;
                      return PieChartSectionData(
                        value: one.value["prize_currency_value"].toDouble(),
                        color: graphColors[xNum2],
                        radius: 80,
                        title: "${one.value["prize_currency"]} ${one.key}",
                        titleStyle: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      );
                    }).toList()
                  ),
                  duration: Duration(milliseconds: 150), // Optional
                  curve: Curves.linear, // Optional
                ),
              )
            ],
          )
          ],
        ),
      ),
    );
  }
}