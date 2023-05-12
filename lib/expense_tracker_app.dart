import 'package:expense_tracker_app/widgets/expenses/add_expense_form.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/data/expenses_data.dart';
import 'package:expense_tracker_app/models/Expense.dart';
import 'package:expense_tracker_app/widgets/expenses/expenses_list.dart';
import 'package:flutter/material.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({Key? key}) : super(key: key);

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  // modal open
  void _openModal({
    required String title,
    required Category category,
    required String amount,
    required DateTime? date,
    required String? expenseId,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      // elevation: 20,
      context: context,
      builder: (ctx) => AddExpenseForm(
        onAddExpense: addNewExpense,
        expenseTitle: title,
        expenseAmount: amount,
        expenseCategory: category,
        expenseDate: date,
        expenseId: expenseId,
        isEditing: false,
        onEditExpense: ({
          required String title,
          required double amount,
          required Category category,
          required DateTime? date,
        }) {},
      ),
    );
  }

  // add new expense
  void addNewExpense(Expense expense) {
    // For updaing UI with every expense add
    setState(() {
      expensesData.add(expense);
    });
  }

  // delete expense
  void removeExpense(Expense expense) {
    // delting the expense from data
    int expenseIndex = expensesData.indexOf(expense);
    setState(
      () {
        expensesData.remove(expense);
      },
    );

    // clear any existing snackbar before showing the new one
    ScaffoldMessenger.of(context).clearSnackBars();

    // show the new snackbar msg
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Successfully deleted the expense',
        ),
        duration: const Duration(seconds: 3),
        action:
            // undo the deletion
            SnackBarAction(
                label: 'undo',
                onPressed: () {
                  setState(() {
                    expensesData.insert(expenseIndex, expense);
                  });
                }),
      ),
    );
  }

  // edit the expense
  void editExpense({
    required String title,
    required double amount,
    required Category category,
    required DateTime date,
    required String expenseId,
  }) {
    Expense exp = expensesData.firstWhere((element) => element.id == expenseId);
    int expIndex = expensesData.indexOf(exp);

    Expense newExpense = Expense(
      title: title,
      price: amount,
      category: category,
      date: date,
    );

    // print(newExpense.title);

    setState(() {
      expensesData[expIndex] = newExpense;
    });

    // expensesData[expIndex].title = title;
    // print('Editing expense');
    // print(expIndex);
  }

  // calculate total expenses
  double get totalExpensesAmount {
    double sum = 0;

    for (var expense in expensesData) {
      sum += expense.price;
    }
    return sum;
  }

  // calculate width for responsiveness

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpenseTracker'),
        actions: [
          IconButton(
            iconSize: 40,
            onPressed: () {
              _openModal(
                title: '',
                amount: '',
                category: Category.food,
                date: null,
                expenseId: null,
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          expensesData.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Opacity(
                    opacity: 0.8,
                    child: Text(
                      'Total Expense: \$$totalExpensesAmount',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 10),

          // conditionally responsive
          (width < 600)
              ? Expanded(
                  child: Column(
                    children: [
                      expensesData.isNotEmpty
                          ? Chart(expenses: expensesData)
                          : const SizedBox(),
                      Expanded(
                        child: ExpensesList(
                          expenses: expensesData,
                          onRemoveExpense: removeExpense,
                          onEditExpense: editExpense,
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Row(
                    children: [
                      expensesData.isNotEmpty
                          ? Expanded(child: Chart(expenses: expensesData))
                          : const SizedBox(),
                      Expanded(
                        child: ExpensesList(
                          expenses: expensesData,
                          onRemoveExpense: removeExpense,
                          onEditExpense: editExpense,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
