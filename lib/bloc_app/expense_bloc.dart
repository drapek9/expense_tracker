
import 'package:expense_tracker/bloc_app/expense_events.dart';
import 'package:expense_tracker/bloc_app/expense_state.dart';
import 'package:expense_tracker/classes_types/classes_types_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  // static final theResponse = _initialGet();

  ExpenseBloc(): super(ExpenseState([], {})) {
    loadGet();
    on<OnAddExpense>((event, emit) {
      state.allExpenses.add(event.theExpense);
      Map<String, Map<dynamic, dynamic>> newOvExpenses = getOverviewStats(state.allExpenses);
      emit(ExpenseState(state.allExpenses, newOvExpenses));
      setToSharedPreferences(state.allExpenses);
    });
    on<OnRemoveExpense>((event, emit) {
      state.allExpenses.remove(event.theExpense);
      Map<String, Map<dynamic, dynamic>> newOvExpenses = getOverviewStats(state.allExpenses);
      emit(ExpenseState(state.allExpenses, newOvExpenses));
      setToSharedPreferences(state.allExpenses);
    },);
  }

  void setToSharedPreferences(allNewExpenses) async{
    List<Map> infExpenses = [];

    allNewExpenses.forEach((one){
      infExpenses.add({
        "name": one.name,
        "category": one.category,
        "time": DateFormat('yyyy-MM-dd HH:mm:ss').format(one.time),
        "prize": one.prize,
        "currency": one.currency
      });
    });

    SharedPreferences theShared = await SharedPreferences.getInstance();
    theShared.setString("allExpense", jsonEncode(infExpenses));
  }
   
  static Map<String, Map<dynamic, dynamic>> getOverviewStats (theList){
    Map<String, Map> theSumExpenses = {"category": {}, "currency": {}};

    theList.forEach((one){
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

  loadGet() async {
    SharedPreferences thePreferences = await SharedPreferences.getInstance();
    // {"category": 0, "currency": 1, "name": "Šimon", "prize": 15, "time": 2024-12-12}
    List allExpenses = jsonDecode(thePreferences.getString("allExpense") ?? "[]");

    List<Expense> allListExpenses = [];

    allExpenses.forEach((oneExpense){
      Expense newExpense = Expense(
        name: oneExpense["name"],
        category: oneExpense["category"],
        time: DateTime.parse(oneExpense["time"]),
        prize: oneExpense["prize"],
        currency: oneExpense["currency"]);
    
      allListExpenses.add(newExpense);
    });

    Map<String, Map<dynamic, dynamic>> theSumExpenses = getOverviewStats(allListExpenses);

    emit(ExpenseState(allListExpenses, theSumExpenses));
  }
}