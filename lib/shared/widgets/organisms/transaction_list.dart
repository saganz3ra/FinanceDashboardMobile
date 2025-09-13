import 'package:flutter/material.dart';
import '../molecules/transaction_list_item.dart';
import '../atoms/app_button.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionListItem> items;
  final VoidCallback? onAdd;
  final String? title;

  const TransactionList({
    super.key,
    required this.items,
    this.onAdd,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(title!, style: Theme.of(context).textTheme.titleLarge),
          ),
        if (onAdd != null)
          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              label: 'Adicionar',
              icon: Icons.add,
              onPressed: onAdd!,
            ),
          ),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }
}
