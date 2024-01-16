import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:organizagro/controllers/inventory_item_controller.dart';
import 'package:organizagro/data/models/inventory_item.dart';
import 'package:organizagro/data/models/iten_category.dart';

class ItemForm extends StatefulWidget {
  final ItemCategory category;

  const ItemForm({Key? key, required this.category}) : super(key: key);

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController(text: 'Operação');
  final _quantity = TextEditingController();
  int _multiplier = 1;
  DateTime? _date;

  int totalAmount = 0;

  Future<void> updateItemCategoryAmount() async {
    final data = await InventoryItemController()
        .getTotalCategoryAmount(widget.category.id);
    setState(() {
      totalAmount = data;
    });
  }

  _pickDate() async {
    DateTime? pickDate = await showDatePicker(
        helpText: 'Selecione a data',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickDate != null) {
      setState(() {
        _date = pickDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateItemCategoryAmount();
  }

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
              Text(
                'Adicionar ${widget.category.name}',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Expanded(child: Text('Tipo de operação')),
                  Column(children: [
                    const Text('Entrada'),
                    Radio(
                      value: 1,
                      groupValue: _multiplier,
                      onChanged: (value) {
                        setState(() {
                          _multiplier = value!;
                        });
                      },
                    ),
                  ]),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Column(children: [
                    const Text('Saída'),
                    Radio(
                      value: -1,
                      groupValue: _multiplier,
                      onChanged: (value) {
                        setState(() {
                          _multiplier = value!;
                        });
                      },
                    ),
                  ])
                ],
              ),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da operação';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                ],
                controller: _quantity,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade';
                  } else if (_multiplier == -1 &&
                      int.parse(_quantity.text) > totalAmount) {
                    return 'Não há estoque disponível';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(_date != null
                          ? DateFormat('dd/MM/yyyy').format(_date!)
                          : 'Data da transação')),
                  IconButton(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final itemToAdd = InventoryItem(
                        id: 0,
                        categoryId: widget.category.id,
                        name: _name.text,
                        quantity: int.parse(_quantity.text),
                        date: _date != null ? _date! : DateTime.now(),
                        multiplier: _multiplier);

                    InventoryItemController().createItem(itemToAdd);

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
