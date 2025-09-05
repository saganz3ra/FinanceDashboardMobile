import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  static Future<double> getDollarValue() async {
    final url = Uri.parse("https://economia.awesomeapi.com.br/json/last/USD-BRL");
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
  DateTime? _selectedDate;
  bool _isIncome = true;
  int? _editingIndex;

  double? _dollarValue;
  String? _dateError;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadDollarValue() async {
    try {
      final value = await CurrencyService.getDollarValue();
      setState(() {
        _dollarValue = value;
      });
    } catch (e) {
      debugPrint("Erro ao buscar dólar: $e");
    }
  }

  void _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
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
      final now = DateTime.now();
      if (_isIncome &&
          _selectedDate!.isAfter(DateTime(now.year, now.month, now.day))) {
        setState(() {
          _dateError = 'Entradas não podem ter data futura';
        });
        return;
      }
      final value = double.parse(_valueController.text);
      final desc = _descController.text;
      final date = _selectedDate!;
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

  void _edit(int index) {
    final t = _transactions[index];
    setState(() {
      _editingIndex = index;
      _valueController.text = t.value.toString();
      _descController.text = t.description;
      _selectedDate = t.date;
      _isIncome = t.isIncome;
    });
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
                          TextFormField(
                            controller: _valueController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Valor',
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Informe o valor';
                              }
                              final val = double.tryParse(v);
                              if (val == null || val <= 0) {
                                return 'Valor inválido';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _descController,
                            decoration: const InputDecoration(
                              labelText: 'Descrição',
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Informe a descrição';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton.icon(
                                  onPressed: () => _pickDate(context),
                                  icon: const Icon(Icons.calendar_today),
                                  label: Text(
                                    _selectedDate == null
                                        ? 'Escolher Data'
                                        : DateFormat('dd/MM/yyyy')
                                            .format(_selectedDate!),
                                  ),
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
                              ],
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
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              t.isIncome
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: t.isIncome ? Colors.green : Colors.red,
                            ),
                            title: Text(
                              '${t.isIncome ? 'Entrada' : 'Saída'}: R\$ ${t.value.toStringAsFixed(2)}',
                            ),
                            subtitle: Text(
                              '${t.description}\n'
                              '${DateFormat('dd/MM/yyyy').format(t.date)}'
                              '${valueInDollar != null ? '\n≈ US\$ ${valueInDollar.toStringAsFixed(2)}' : ''}',
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _edit(i),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _delete(i),
                                ),
                              ],
                            ),
                          ),
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
