import 'package:expense_tracker/classes_types/classes_types_main.dart';

abstract class ExpenseEvent {}

class OnAddExpense extends ExpenseEvent {
  final Expense theExpense;

  OnAddExpense(this.theExpense);
}

class OnRemoveExpense extends ExpenseEvent {
  final Expense theExpense;

  OnRemoveExpense(this.theExpense);
}