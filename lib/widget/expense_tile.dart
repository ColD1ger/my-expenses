import 'package:flutter/material.dart';
import 'package:myspendings/model/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  const ExpenseTile({
    super.key,
    required this.expense,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(
        expense.category.emoji,
        style: const TextStyle(fontSize: 28),
      ),
      title: Text(
        expense.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(expense.category.title),
      trailing: Text(
        '${expense.amount} դր.',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
