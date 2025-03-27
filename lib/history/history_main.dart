import 'package:expense_tracker/bloc_app/expense_bloc.dart';
import 'package:expense_tracker/bloc_app/expense_events.dart';
import 'package:expense_tracker/bloc_app/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/classes_types/classes_types_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final blocProv = context.read<ExpenseBloc>();

    void removeExpense(theExpense){
      blocProv.add(OnRemoveExpense(theExpense));
    }

    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state){
          return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemCount: state.allExpenses.length,
          itemBuilder: (context, index){
            Expense theWidget = state.allExpenses[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 7.5),
              child: SizedBox(
                height: 100,
                child: Card(
                  color: const Color.fromARGB(255, 242, 242, 242),
                  child: InkWell(
                    onTap: (){
                      showDeleteOption(context, theWidget, removeExpense);
                    },
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
              ),
            );
          }
          );
        })
      ),
    );
  }
}

void showDeleteOption(context, theExpense, deleteFunction){
  Function theFunction = deleteFunction;
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 150,
        width: double.infinity,
        child: Container(
          color: const Color.fromARGB(255, 242, 242, 242),
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              ),
              onPressed: (){
                theFunction(theExpense);
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                )),
          ),
        ),
      );
    });
}