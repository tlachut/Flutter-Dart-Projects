import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:expense_tracker/models/expense.dart';

class EditExpense extends StatefulWidget {
  const EditExpense(this.expense, this.onEditExpense, {super.key});

  final Expense expense;
  final void Function(Expense expense) onEditExpense;

  @override
  State<EditExpense> createState() {
    return _EditExpenseState();
  }
}

class _EditExpenseState extends State<EditExpense> {
  late final _titleController = TextEditingController(text: widget.expense.title);
  late final _amountController = TextEditingController(text: widget.expense.amount.toString());
  late DateTime? _selectedDate = widget.expense.date;
  late Category _selectedCategory = widget.expense.category;

  void _openDatePicker() async {
    final nowDate = DateTime.now();
    final firstDate = DateTime(nowDate.year - 1, nowDate.month, nowDate.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: nowDate,
      firstDate: firstDate,
      lastDate: nowDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Invalid data'),
          content: const Text(
            'Please ensure that you have entered the correct title and amount and selected the date and category.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid data'),
          content: const Text(
            'Please ensure that you have entered the correct title and amount and selected the date and category.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitEditExpense() {
    final invalidTitle = _titleController.text.isEmpty;
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount < 0;
    final invalidDate = _selectedDate == null;

    if (invalidTitle || invalidAmount || invalidDate) {
      _showDialog();
      return;
    }

    widget.onEditExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (cts, constrains) {
        final width = constrains.maxWidth;

        return SizedBox(
          width: double.infinity,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Edit expense'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      if (width > 600)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _titleController,
                                maxLength: 50,
                                decoration: const InputDecoration(
                                  label: Text('Title'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: _amountController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                inputFormatters: [
                                  _CommaToDecimalFormatter(),
                                ],
                                decoration: const InputDecoration(
                                  label: Text('Amount'),
                                  prefixText: '\$ ',
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      if (width > 600)
                        Row(
                          children: [
                            DropdownButton<Category>(
                              value: _selectedCategory,
                              items: Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category.name[0].toUpperCase() +
                                            category.name.substring(1),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  if (value == null) {
                                    return;
                                  }
                                  _selectedCategory = value;
                                });
                              },
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _selectedDate == null
                                        ? 'Date not selected'
                                        : dateFormatter.format(_selectedDate!),
                                  ),
                                  IconButton(
                                    onPressed: _openDatePicker,
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: _submitEditExpense,
                              child: const Text('Save'),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _amountController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                inputFormatters: [
                                  _CommaToDecimalFormatter(),
                                ],
                                decoration: const InputDecoration(
                                  label: Text('Amount'),
                                  prefixText: '\$ ',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _selectedDate == null
                                        ? 'Date not selected'
                                        : dateFormatter.format(_selectedDate!),
                                  ),
                                  IconButton(
                                    onPressed: _openDatePicker,
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (width < 600) const SizedBox(height: 12),
                      if (width < 600)
                        Row(
                          children: [
                            DropdownButton<Category>(
                              value: _selectedCategory,
                              items: Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category.name[0].toUpperCase() +
                                            category.name.substring(1),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  if (value == null) {
                                    return;
                                  }
                                  _selectedCategory = value;
                                });
                              },
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: _submitEditExpense,
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// AI-generated class to replace commas (“,”) with periods (“.”) due to a different separator (location-related) to be consistent with the course lesson.
class _CommaToDecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(',', '.');
    return newValue.copyWith(text: newText);
  }
}
