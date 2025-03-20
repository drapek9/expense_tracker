
import 'package:expense_tracker/classes_types/classes_types_main.dart';

class ExpenseState {
  final List<Expense> allExpenses;
  final Map<String, Map> allExpensesOverview;

  ExpenseState(this.allExpenses, this.allExpensesOverview);
}