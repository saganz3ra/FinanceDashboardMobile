import 'package:flutter/material.dart';
import '../../widgets/atoms/app_text_field.dart';

class TransactionForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController valueController;
  final TextEditingController descController;
  final TextEditingController dateController;
  final DateTime? selectedDate;
  final bool isIncome;
  final String? dateError;
  final VoidCallback onPickDate;
  final VoidCallback onSubmit;
  final ValueChanged<bool> onIncomeChanged;

  const TransactionForm({
    super.key,
    required this.formKey,
    required this.valueController,
    required this.descController,
    required this.dateController,
    required this.selectedDate,
    required this.isIncome,
    required this.dateError,
    required this.onPickDate,
    required this.onSubmit,
    required this.onIncomeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextField(
            label: 'Valor',
            controller: valueController,
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
            controller: descController,
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
                  controller: dateController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a data';
                    }
                    final regex = RegExp(newMethod);
                    if (!regex.hasMatch(value)) {
                      return 'Formato inválido (dd/mm/aaaa)';
                    }
                    return null;
                  },
                ),
              ),
              TextButton.icon(
                onPressed: onPickDate,
                icon: const Icon(Icons.calendar_today),
                label: const Text('Escolher'),
              ),
            ],
          ),
          if (dateError != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 2.0),
              child: Text(
                dateError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          RadioGroup<bool>(
            groupValue: isIncome,
            onChanged: (v) {
              if (v == null) return;
              onIncomeChanged(v);
            },
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Entrada'),
                    value: true,
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Saída'),
                    value: false,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(onPressed: onSubmit, child: const Text('Salvar')),
        ],
      ),
    );
  }

  String get newMethod => r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$';
}
