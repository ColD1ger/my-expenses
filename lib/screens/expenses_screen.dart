import 'package:flutter/material.dart';
import 'package:myspendings/model/expense.dart';
import 'package:myspendings/widget/category_filter.dart';
import 'package:myspendings/widget/expense_form.dart';
import 'package:myspendings/widget/expense_tile.dart';
import '../data/dummy_expenses.dart';
import 'edit_expense_screen.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _expenses = List.of(initialExpenses);
  Category? _selectedFilter;

  // Ֆիլտրված ցուցակ
  List<Expense> get _filteredExpenses {
    if (_selectedFilter == null) {
      return _expenses;
    }
    return _expenses
        .where((expense) => expense.category == _selectedFilter)
        .toList();
  }

  // Ընդհանուր գումարը հաշվվում է դինամիկ՝ առանց առանձին փոփոխականի
  int get _totalAmount {
    return _filteredExpenses.fold(0, (sum, item) => sum + item.amount);
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.insert(0, expense);
    });
  }

  void _removeExpense(Expense expense) {
    final originalIndex = _expenses.indexOf(expense);

    setState(() {
      _expenses.removeAt(originalIndex);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('«${expense.title}» ծախսը ջնջվեց'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Վերադարձնել',
          onPressed: () {
            setState(() {
              _expenses.insert(originalIndex, expense);
            });
          },
        ),
      ),
    );
  }

  Future<void> _openEditScreen(Expense expense) async {
    final newAmount = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (ctx) => EditExpenseScreen(expense: expense),
      ),
    );

    if (newAmount != null) {
      final index = _expenses.indexWhere((e) => e.id == expense.id);
      if (index != -1) {
        setState(() {
          _expenses[index] = expense.copyWith(amount: newAmount);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleExpenses = _filteredExpenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ընդամենը՝ $_totalAmount դր.'),
      ),
      body: Column(
        children: [
          ExpenseForm(onAddExpense: _addExpense),
          const Divider(height: 1),
          const SizedBox(height: 8),
          CategoryFilter(
            selectedCategory: _selectedFilter,
            onSelectCategory: (category) {
              setState(() {
                _selectedFilter = category;
              });
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: visibleExpenses.isEmpty
                ? const Center(
                    child: Text(
                      'Ծախսեր չկան։ Ավելացրեք ձեր առաջին ծախսը վերևում։',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    itemCount: visibleExpenses.length,
                    separatorBuilder: (ctx, index) => const Divider(height: 1),
                    itemBuilder: (ctx, index) {
                      final expense = visibleExpenses[index];
                      return Dismissible(
                        key: ValueKey(expense.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => _removeExpense(expense),
                        child: ExpenseTile(
                          expense: expense,
                          onTap: () => _openEditScreen(expense),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
