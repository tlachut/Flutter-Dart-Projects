import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/edit_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expensesList = [
    Expense(
      title: 'Flutter course ',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema ticket',
      amount: 9.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: Colors.white.withOpacity(0),
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _openEditExpenseOverlay(Expense oldExpense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: Colors.white.withOpacity(0),
      builder: (ctx) => EditExpense(
        oldExpense,
        (newExpense) => _editExpense(oldExpense, newExpense),
      ),
    );
  }

  void _editExpense(Expense oldExpense, Expense newExpense) {
    final expenseIndex = _expensesList.indexOf(oldExpense);
    setState(() {
      _expensesList[expenseIndex] = newExpense;
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);

    setState(() {
      _expensesList.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Deleted expense.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expensesList,
        onRemoveExpense: _removeExpense,
        onEditExpense: _openEditExpenseOverlay,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: width < 600
            ? Column(
                children: [
                  Chart(expenses: _expensesList),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _expensesList),
                  ),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ),
      ),
    );
  }
}
