import 'package:flutter/material.dart';
import 'package:organizagro/data/models/iten_category.dart';

class CategoryInfo extends StatelessWidget {
  final ItemCategory category;
  final int totalAmount;

  const CategoryInfo(
      {super.key, required this.category, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.name,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Estoque:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('$totalAmount ${category.unitOfMeasure}'),
            ],
          ),
        ),
      ),
    );
  }
}
