import 'dart:io';
import 'package:expense_tracker_app/models/Expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var dateFormatter = DateFormat('dd-MM-yy');

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({
    super.key,
    required this.onAddExpense,
    required this.onEditExpense,
    required this.expenseTitle,
    required this.expenseAmount,
    required this.expenseCategory,
    required this.expenseDate,
    required this.expenseId,
    required this.isEditing,
  });

  final void Function(Expense expense) onAddExpense;
  final void Function({
    required String title,
    required double amount,
    required Category category,
    required DateTime date,
  }) onEditExpense;
  final String expenseTitle;
  final String expenseAmount;
  final Category expenseCategory;
  final DateTime? expenseDate;

  final String? expenseId;
  final bool isEditing;

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _amountEditingController =
      TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  late bool _isEditing;

  // intialize the state
  @override
  void initState() {
    super.initState();
    _titleEditingController.text = widget.expenseTitle;
    _amountEditingController.text = widget.expenseAmount;
    _selectedCategory = widget.expenseCategory;
    _selectedDate = widget.expenseDate;
    _isEditing = widget.isEditing;
  }

  // open date picker and pick date
  Future<void> _openDatePicker() async {
    final now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(
        now.year - 1,
        now.month,
        now.day,
      ),
      lastDate: DateTime(
        now.year + 1,
        now.month,
        now.day,
      ),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // show alert dialog
  void _showAlertDialog(BuildContext context) {
    bool isIos = Platform.isIOS;

    isIos
        ? showCupertinoDialog(
            context: context,
            builder: (ctx) {
              return CupertinoAlertDialog(
                title: const Text('Invalid Inputs'),
                content: const Text(
                    'Please make sure you have entered valid expense title, amount, date and category.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  )
                ],
              );
            },
          )
        : showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Invalid Inputs'),
                content: const Text(
                    'Please make sure you have entered valid expense title, amount, date and category.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  )
                ],
              );
            },
          );
  }

  // submit new expense
  void submitNewExpense() {
    double? enteredAmount = double.tryParse(_amountEditingController.text);
    final titleiIsInvalid = _titleEditingController.text.trim().isEmpty;
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final dateIsInvalid = _selectedDate == null;

    if (titleiIsInvalid || amountIsInvalid || dateIsInvalid) {
      // show error message as dialog
      _showAlertDialog(context);
    } else {
      // print('Submit new expense');
      if (_isEditing) {
        widget.onEditExpense(
            title: _titleEditingController.text,
            amount: double.parse(_amountEditingController.text),
            date: _selectedDate!,
            category: _selectedCategory);

        Navigator.pop(context);
        return;
      }
      Expense newExpense = Expense(
        title: _titleEditingController.text,
        price: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      );
      widget.onAddExpense(newExpense);
      Navigator.pop(context); // close the modal
    }
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _amountEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For debugging

    // print(widget.expenseTitle);
    // print(widget.expenseAmount);
    // print(widget.expenseDate);
    // print(widget.expenseCategory);

    return LayoutBuilder(
      builder: (ctx, constrains) {
        // getting the max width of the modal window
        double width = constrains.maxWidth;
        // print(width);
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              width < 600
                  ? TextField(
                      controller: _titleEditingController,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      maxLength: 50,
                    )
                  : const SizedBox(),
              Row(
                children: [
                  width > 600
                      ? Expanded(
                          child: TextField(
                            controller: _titleEditingController,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                            maxLength: 50,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _amountEditingController,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        label: Text('Amount'),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate != null
                            ? dateFormatter.format(
                                _selectedDate!) // forcefull tale dart that _selectedDate is not null
                            : 'Select Date'),
                        const SizedBox(width: 4),
                        IconButton(
                            onPressed: _openDatePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 4),
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem<Category>(
                            value: category, // TODO: Very important
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (Category? value) {
                      if (value != null && value != _selectedCategory) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: submitNewExpense,
                        child:
                            Text(_isEditing ? 'Update Expense' : 'Add Expense'),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
