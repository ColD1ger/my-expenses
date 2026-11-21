import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myspendings/model/expense.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const ExpenseForm({super.key, required this.onAddExpense});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;

  void _submitData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = int.tryParse(_amountController.text.trim());

    if (enteredTitle.isEmpty || enteredAmount == null || enteredAmount <= 0) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Խնդրում ենք մուտքագրել ճիշտ անվանում և գումար։'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newExpense = Expense(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: enteredTitle,
      amount: enteredAmount,
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);

    _titleController.clear();
    _amountController.clear();
    setState(() {
      _selectedCategory = Category.food;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Անվանում',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Գումար',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            children: Category.values.map((category) {
              return ChoiceChip(
                label: Text('${category.emoji} ${category.title}'),
                selected: _selectedCategory == category,
                onSelected: (isSelected) {
                  if (isSelected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text('Ավելացնել'),
          ),
        ],
      ),
    );
  }
}
