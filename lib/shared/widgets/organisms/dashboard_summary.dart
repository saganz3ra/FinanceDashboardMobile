import 'package:flutter/material.dart';
import '../molecules/finance_info_card.dart';

class DashboardSummary extends StatelessWidget {
  final List<FinanceInfoCard> cards;
  final String? title;

  const DashboardSummary({super.key, required this.cards, this.title});

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
        Wrap(spacing: 16, runSpacing: 16, children: cards),
      ],
    );
  }
}
