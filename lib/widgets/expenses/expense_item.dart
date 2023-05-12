import 'package:expense_tracker_app/models/Expense.dart';
import 'package:expense_tracker_app/widgets/expenses/add_expense_form.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    Key? key,
    required this.expense,
    required this.expenseId,
    required this.editExpense,
  }) : super(key: key);

  final Expense expense;
  final String expenseId;
  final void Function({
    required String title,
    required double amount,
    required Category category,
    required DateTime date,
    required String expenseId,
  }) editExpense;

  void _openModal(
    BuildContext context, {
    required String title,
    required Category category,
    required String amount,
    required DateTime? date,
    required String? expenseId,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => AddExpenseForm(
        onAddExpense: (Expense exp) {},
        expenseTitle: title,
        expenseAmount: amount,
        expenseCategory: category,
        expenseDate: date,
        expenseId: expenseId,
        isEditing: true,
        onEditExpense: ({
          required String title,
          required double amount,
          required Category category,
          required DateTime date,
        }) {
          editExpense(
            title: title,
            amount: amount,
            category: category,
            date: date,
            expenseId: expenseId!,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openModal(
          context,
          title: '',
          category: Category.leisure,
          amount: '',
          date: DateTime.now(),
          expenseId: expenseId,
        );
      },
      child: Card(
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '\$${expense.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(width: 8),
                      Text(
                        expense.formattedDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
