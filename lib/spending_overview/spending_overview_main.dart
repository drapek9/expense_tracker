import 'package:expense_tracker/bloc_app/expense_bloc.dart';
import 'package:expense_tracker/bloc_app/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpendingOverviewScreen extends StatefulWidget {
  // const SpendingOverviewScreen({super.key});


  @override
  State<SpendingOverviewScreen> createState() => _SpendingOverviewScreenState();
}

class _SpendingOverviewScreenState extends State<SpendingOverviewScreen> {

  List graphColors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.brown, Colors.black];

  int xNum = -1;
  Map xNumValue = {};
  int xNum2 = -1;

  @override
  Widget build(BuildContext context) {
    xNum = -1;
    xNum2 = -1;
    xNumValue = {};
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: BlocBuilder<ExpenseBloc,ExpenseState>(
            builder: (context, state){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
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
                                barGroups: state.allExpensesOverview["category"]!.entries.map((one) {
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
                    ),
                  ),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
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
                              sections: state.allExpensesOverview["currency"]!.entries.map((one){
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
                    ),
                  ),
                )
                ],
              ),
            );}
          ),
        ),
      ),
    );
  }
}