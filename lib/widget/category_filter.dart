import 'package:flutter/material.dart';
import 'package:myspendings/model/expense.dart';

class CategoryFilter extends StatelessWidget {
  final Category? selectedCategory;
  final void Function(Category? category) onSelectCategory;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: const Text('Բոլորը'),
              selected: selectedCategory == null,
              onSelected: (_) => onSelectCategory(null),
            ),
          ),
          ...Category.values.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text('${category.emoji} ${category.title}'),
                selected: selectedCategory == category,
                onSelected: (_) => onSelectCategory(category),
              ),
            );
          }),
        ],
      ),
    );
  }
}
