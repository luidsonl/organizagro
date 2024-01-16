import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:organizagro/controllers/cash_transaction_controller.dart';
import 'package:organizagro/data/models/cash_transaction.dart';

class TransactionForm extends StatefulWidget {
  final VoidCallback? updateState;

  const TransactionForm({super.key, this.updateState});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController(text: 'Operação');
  final _amount = TextEditingController();
  int _multiplier = 1;
  DateTime? _date;

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
                'Adicionar Transação',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+([\.,]\d{0,2})?')),
                ],
                controller: _amount,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade';
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
                    final itemToAdd = CashTransaction(
                        id: 0,
                        name: _name.text,
                        amount: double.parse(_amount.text.replaceAll(',', '.')),
                        date: _date != null ? _date! : DateTime.now(),
                        multiplier: _multiplier);

                    CashTransactionController().createTransaction(itemToAdd);

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
