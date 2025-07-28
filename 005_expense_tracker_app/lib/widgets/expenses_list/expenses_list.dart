import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.expenses,
    required this.onRemoveExpense,
    required this.onEditExpense,
    super.key,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  final void Function(Expense expense) onEditExpense;
  // final void Function() onEditExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: GestureDetector(
          onTap: () {
            onEditExpense(expenses[index]);
          },
          child: ExpenseItem(
            expense: expenses[index],
          ),
        ),
      ),
    );
  }
}
