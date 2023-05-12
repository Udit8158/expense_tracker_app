// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
var dateFormatter = DateFormat('dd-MM-yy');

// predefined categories
enum Category {
  food,
  travel,
  leisure,
  work,
}

// categories icons
Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.price,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String title;
  double price;
  DateTime date;
  final String id;
  Category category;

  // getter method
  String get formattedDate {
    return dateFormatter.format(date);
  }
}

// Bucketing the expenses

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  // utility constructor (An Exptra Constructor) to filter the expenses by category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  // getter total amount
  double get totalExpenses {
    double sum = 0;

    for (var element in expenses) {
      sum += element.price;
    }
    return sum;
  }
}
