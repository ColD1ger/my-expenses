enum Category {
  food('Սնունդ', '🍔'),
  vehicle('Տրանսպորտ', '🚌'),
  entertainment('Զվարճանք', '🎮'),
  other('Այլ', '📦');

  final String title;
  final String emoji;

  const Category(this.title, this.emoji);
}

class Expense {
  final String id;
  final String title;
  final int amount;
  final Category category;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
  });

  Expense copyWith({
    String? id,
    String? title,
    int? amount,
    Category? category,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
    );
  }
}
