import 'package:flutter/material.dart';
import 'package:financedashboard/shared/constants/colors.dart';
import 'package:financedashboard/shared/widgets/atoms/app_button.dart';
import 'package:financedashboard/shared/widgets/molecules/finance_info_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Semantics(
              header: true,
              label: 'Resumo Financeiro',
              child: Text(
                "Resumo Financeiro",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FinanceInfoCard(
              icon: Icons.account_balance_wallet,
              title: "Saldo Atual",
              subtitle: "R\$ 12.345,67",
              iconColor: AppColors.primary,
              semanticsLabel: 'Saldo atual da conta',
            ),
            const SizedBox(height: 12),
            FinanceInfoCard(
              icon: Icons.arrow_upward,
              title: "Entradas",
              subtitle: "R\$ 7.890,00",
              iconColor: AppColors.success,
              semanticsLabel: 'Entradas financeiras',
            ),
            const SizedBox(height: 12),
            FinanceInfoCard(
              icon: Icons.arrow_downward,
              title: "Saídas",
              subtitle: "R\$ 5.432,00",
              iconColor: AppColors.error,
              semanticsLabel: 'Saídas financeiras',
            ),
            const SizedBox(height: 24),
            AppButton(
              label: "Atualizar",
              icon: Icons.refresh,
              color: AppColors.accent,
              semanticsLabel: 'Botão para atualizar o dashboard',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dashboard atualizado!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
