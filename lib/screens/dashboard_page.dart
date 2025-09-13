import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../shared/widgets/atoms/app_text_field.dart';
import '../shared/widgets/molecules/transaction_list_item.dart';

class CurrencyService {
  static Future<double> getDollarValue() async {
    final url = Uri.parse(
      "https://economia.awesomeapi.com.br/json/last/USD-BRL",
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final value = double.parse(data["USDBRL"]["bid"]);
      return value;
    } else {
      throw Exception("Erro ao buscar valor do dólar");
    }
  }
}

class Transaction {
  double value;
  String description;
  DateTime date;
  bool isIncome;
  Transaction({
    required this.value,
    required this.description,
    required this.date,
    required this.isIncome,
  });
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = _selectedDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _edit(int index) {
    final t = _transactions[index];
    setState(() {
      _editingIndex = index;
      _valueController.text = t.value.toString();
      _descController.text = t.description;
      _selectedDate = t.date;
      _dateController.text = DateFormat('dd/MM/yyyy').format(t.date);
      _isIncome = t.isIncome;
    });
  }

  final List<Transaction> _transactions = [];
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  bool _isIncome = true;
  int? _editingIndex;

  double? _dollarValue;
  String? _dateError;

  void _submit() {
    setState(() {
      _dateError = null;
    });
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        setState(() {
          _dateError = 'Selecione uma data';
        });
        return;
      }
      final value = double.tryParse(_valueController.text);
      final desc = _descController.text.trim();
      final date = _selectedDate!;
      // Validação valor
      if (value == null || value <= 0) {
        setState(() {
          _dateError = 'Valor deve ser maior que zero';
        });
        return;
      }
      if (value > 1000000) {
        setState(() {
          _dateError = 'Valor máximo permitido: 1.000.000';
        });
        return;
      }
      // Validação descrição
      if (desc.isEmpty) {
        setState(() {
          _dateError = 'Descrição obrigatória';
        });
        return;
      }
      if (desc.length < 3) {
        setState(() {
          _dateError = 'Descrição muito curta';
        });
        return;
      }
      if (desc.length > 100) {
        setState(() {
          _dateError = 'Descrição muito longa';
        });
        return;
      }
      // Duplicidade
      final isDuplicate = _transactions.any(
        (t) =>
            t.value == value &&
            t.description.trim() == desc &&
            t.date == date &&
            t.isIncome == _isIncome,
      );
      if (_editingIndex == null && isDuplicate) {
        setState(() {
          _dateError = 'Transação idêntica já cadastrada';
        });
        return;
      }
      if (_editingIndex == null) {
        _transactions.add(
          Transaction(
            value: value,
            description: desc,
            date: date,
            isIncome: _isIncome,
          ),
        );
      } else {
        _transactions[_editingIndex!] = Transaction(
          value: value,
          description: desc,
          date: date,
          isIncome: _isIncome,
        );
      }
      setState(() {
        _editingIndex = null;
        _valueController.clear();
        _descController.clear();
        _selectedDate = null;
        _isIncome = true;
        _dateError = null;
      });
    }
  }

  void _delete(int index) {
    setState(() {
      _transactions.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = null;
        _valueController.clear();
        _descController.clear();
        _selectedDate = null;
        _isIncome = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_dollarValue != null)
              Text(
                "1 USD = R\$ ${_dollarValue!.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 16),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _editingIndex == null
                          ? 'Adicionar Transação'
                          : 'Editar Transação',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextField(
                            label: 'Valor',
                            controller: _valueController,
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Informe o valor';
                              }
                              final val = double.tryParse(v);
                              if (val == null || val <= 0) {
                                return 'Valor deve ser maior que zero';
                              }
                              if (val > 1000000) {
                                return 'Valor máximo permitido: 1.000.000';
                              }
                              return null;
                            },
                          ),
                          AppTextField(
                            label: 'Descrição',
                            controller: _descController,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Descrição obrigatória';
                              }
                              if (v.trim().length < 3) {
                                return 'Descrição muito curta';
                              }
                              if (v.trim().length > 100) {
                                return 'Descrição muito longa';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  label: 'Data (dd/mm/aaaa)',
                                  controller: _dateController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    TextInputFormatter.withFunction((
                                      oldValue,
                                      newValue,
                                    ) {
                                      var text = newValue.text;
                                      if (text.length > 2 && text[2] != '/') {
                                        text =
                                            '${text.substring(0, 2)}/${text.substring(2)}';
                                      }
                                      if (text.length > 5 && text[5] != '/') {
                                        text =
                                            '${text.substring(0, 5)}/${text.substring(5)}';
                                      }
                                      if (text.length > 10) {
                                        text = text.substring(0, 10);
                                      }
                                      return TextEditingValue(
                                        text: text,
                                        selection: TextSelection.collapsed(
                                          offset: text.length,
                                        ),
                                      );
                                    }),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Informe a data';
                                    }
                                    final regex = RegExp(
                                      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$',
                                    );
                                    if (!regex.hasMatch(value)) {
                                      return 'Formato inválido (dd/mm/aaaa)';
                                    }
                                    // Atualiza _selectedDate se o valor for válido
                                    final parts = value.split('/');
                                    final day = int.tryParse(parts[0]);
                                    final month = int.tryParse(parts[1]);
                                    final year = int.tryParse(parts[2]);
                                    if (day != null &&
                                        month != null &&
                                        year != null) {
                                      final date = DateTime(year, month, day);
                                      if (_selectedDate == null ||
                                          _selectedDate!.day != day ||
                                          _selectedDate!.month != month ||
                                          _selectedDate!.year != year) {
                                        setState(() {
                                          _selectedDate = date;
                                        });
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  _pickDate(context);
                                  if (_selectedDate != null) {
                                    _dateController.text = DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(_selectedDate!);
                                  }
                                },
                                icon: const Icon(Icons.calendar_today),
                                label: const Text('Escolher'),
                              ),
                            ],
                          ),
                          if (_dateError != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                top: 2.0,
                              ),
                              child: Text(
                                _dateError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<bool>(
                                  title: const Text('Entrada'),
                                  value: true,
                                  groupValue: _isIncome,
                                  onChanged: (v) =>
                                      setState(() => _isIncome = v!),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<bool>(
                                  title: const Text('Saída'),
                                  value: false,
                                  groupValue: _isIncome,
                                  onChanged: (v) =>
                                      setState(() => _isIncome = v!),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: _submit,
                            child: Text(
                              _editingIndex == null ? 'Adicionar' : 'Salvar',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Transações',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _transactions.isEmpty
                  ? const Center(child: Text('Nenhuma transação cadastrada'))
                  : ListView.builder(
                      itemCount: _transactions.length,
                      itemBuilder: (context, i) {
                        final t = _transactions[i];
                        final valueInDollar = (_dollarValue != null)
                            ? (t.value / _dollarValue!)
                            : null;
                        return TransactionListItem(
                          icon: t.isIncome
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          iconColor: t.isIncome ? Colors.green : Colors.red,
                          title:
                              '${t.isIncome ? 'Entrada' : 'Saída'}: R\$ ${t.value.toStringAsFixed(2)}',
                          subtitle:
                              '${t.description}\n${DateFormat('dd/MM/yyyy').format(t.date)}${valueInDollar != null ? '\n≈ US\$ ${valueInDollar.toStringAsFixed(2)}' : ''}',
                          isThreeLine: true,
                          onEdit: () => _edit(i),
                          onDelete: () => _delete(i),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
