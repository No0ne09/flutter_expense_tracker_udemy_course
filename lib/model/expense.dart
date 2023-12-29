import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat().add_yMMMMd();

enum Category { food, travel, leisure, work }

const catIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.date,
    required this.title,
    required this.amount,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get datestring {
    return formatter.format(date);
  }
}

class Bucket {
  Bucket({required this.expenses, required this.category});
  Bucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where(
              (expense) => expense.category == category,
            )
            .toList();
  final List<Expense> expenses;
  final Category category;

  double get sumOf {
    double sum = 0.0;
    for (final item in expenses) {
      sum += item.amount;
    }
    return sum;
  }
}
