import 'package:flutter/material.dart';
import 'package:organizagro/constants/icons.dart';
import 'package:organizagro/controllers/item_category_controller.dart';
import 'package:organizagro/data/models/iten_category.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({Key? key}) : super(key: key);

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _unitOfMeasure = TextEditingController(text: 'Unidades');
  String _icon = 'inventário';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Criar nova categoria',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da categoria';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unitOfMeasure,
                decoration: const InputDecoration(
                    labelText: 'Unidade de medida (kg, L)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a unidade de medida';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _icon,
                items: categoryIcons.keys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Row(
                      children: <Widget>[
                        Icon(categoryIcons[key]),
                        const SizedBox(width: 10),
                        Text(key),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _icon = value!;
                  });
                },
                decoration:
                    const InputDecoration(labelText: 'Selecione o ícone'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newCategory = ItemCategory(
                        id: 0,
                        icon: _icon,
                        unitOfMeasure: _unitOfMeasure.text,
                        name: _name.text);

                    ItemCategoryController().createCategory(newCategory);
                    Navigator.of(context).pop();
                  }
                },
                label: const Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
