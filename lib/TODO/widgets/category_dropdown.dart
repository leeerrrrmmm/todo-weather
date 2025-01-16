import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  const CategoryDropdown({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String?>(
      value: selectedCategory,
      hint: const Text('Категории'),
      onChanged: onCategorySelected,
      items: <String?>[null, 'Работа', 'Личное', 'Дом']
          .map((String? category) {
        return DropdownMenuItem<String?>(
          value: category,
          child: Text(category ?? 'Все задачи'),
        );
      }).toList(),
    );
  }
}
