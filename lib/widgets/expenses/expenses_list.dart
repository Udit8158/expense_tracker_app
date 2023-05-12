import 'package:expense_tracker_app/widgets/expenses/expense_item.dart';
import 'package:expense_tracker_app/models/Expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.expenses,
    required this.onRemoveExpense,
    required this.onEditExpense,
  }) : super(key: key);

  final void Function(Expense expense) onRemoveExpense; // removeitem
  final void Function({
    required String title,
    required double amount,
    required Category category,
    required DateTime date,
    required String expenseId,
  }) onEditExpense;

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
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
          expenseId: expenses[index].id,
          editExpense: onEditExpense,
        ),
      ),
    );
  }
}
