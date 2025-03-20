
import 'package:expense_tracker/bloc_app/expense_events.dart';
import 'package:expense_tracker/bloc_app/expense_state.dart';
import 'package:expense_tracker/classes_types/classes_types_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc(): super(ExpenseState([
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
  ])) {
    on<OnAddExpense>((event, emit) {
      state.allExpenses.add(event.theExpense);
      emit(ExpenseState(state.allExpenses));
    });
    on<OnRemoveExpense>((event, emit) {
      state.allExpenses.remove(event.theExpense);
      emit(ExpenseState(state.allExpenses));
    },);
  }
}