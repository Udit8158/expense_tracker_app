import 'package:expense_tracker_app/models/Expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var dateFormatter = DateFormat('dd-MM-yy');

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _amountEditingController =
      TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // error message
  // bool _showErrorMessage = false;

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

  // submit new expense
  void submitNewExpense() {
    double? enteredAmount = double.tryParse(_amountEditingController.text);
    final titleiIsInvalid = _titleEditingController.text.trim().isEmpty;
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final dateIsInvalid = _selectedDate == null;

    if (titleiIsInvalid || amountIsInvalid || dateIsInvalid) {
      // show error message
      showDialog(
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
          });
    } else {
      // print('Submit new expense');
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
    // print(Category.values.map((e) => e.name).toList());
    double keyboadSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; // calculate the how much space keyboad take
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleEditingController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            maxLength: 50,
          ),
          Row(
            children: [
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
                    child: const Text("Add Expense"),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
