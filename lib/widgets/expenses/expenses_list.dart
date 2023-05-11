import 'package:expense_tracker_app/widgets/expenses/expense_item.dart';
import 'package:expense_tracker_app/models/Expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;

  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    // print('Expenses ${expenses[0].title} ----------');
    // return Text('data');
    if (expenses.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 100),
        child: Text(
          'You have no expenses to show. Add one by clicking on the add button on top.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      );
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              background: Card(
                color: Theme.of(context).colorScheme.error.withOpacity(0.7),
              ),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              key: ValueKey(expenses[index]),
              child: ExpenseItem(
                expense: expenses[index],
              ),
            ));
  }
}
