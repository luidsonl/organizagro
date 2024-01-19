import 'package:flutter/material.dart';
import '../../../data/models/iten_category.dart';
import 'category_card.dart';

class CategoryList extends StatelessWidget {
  final List<ItemCategory> categoryList;
  final VoidCallback? updateState;

  const CategoryList({
    super.key,
    required this.categoryList,
    this.updateState,
  });

  @override
  Widget build(BuildContext context) {
    if (categoryList.isEmpty) {
      return const Center(child: Text('Sem categorias cadastradas'));
    } else {
      return ListView.builder(
        itemBuilder: (_, i) => CategoryCard(
          itemCategory: categoryList[i],
          updateState: updateState,
        ),
        itemCount: categoryList.length,
      );
    }
  }
}
