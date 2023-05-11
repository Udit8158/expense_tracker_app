import 'package:expense_tracker_app/models/Expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(expense.title,
              style: const TextStyle(
                // color: Color.fromARGB(143, 0, 0, 0),
                fontWeight: FontWeight.w500,
                fontSize: 22,
              )),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('\$${expense.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    // color: Color.fromARGB(143, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8),
                  Text(expense.formattedDate,
                      style: const TextStyle(
                        // color: Color.fromARGB(143, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      )),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
