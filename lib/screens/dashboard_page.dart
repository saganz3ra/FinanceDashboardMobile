import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../shared/widgets/organisms/transaction_form.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchDollarValue();
  }

  Future<void> _fetchDollarValue() async {
    try {
      final value = await CurrencyService.getDollarValue();
      setState(() {
        _dollarValue = value;
      });
    } catch (_) {}
  }

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
                    TransactionForm(
                      formKey: _formKey,
                      valueController: _valueController,
                      descController: _descController,
                      dateController: _dateController,
                      selectedDate: _selectedDate,
                      isIncome: _isIncome,
                      dateError: _dateError,
                      onPickDate: () => _pickDate(context),
                      onSubmit: _submit,
                      onIncomeChanged: (v) => setState(() => _isIncome = v),
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
