import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Resumo Financeiro", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.blue[700]),
                title: Text("Saldo Atual"),
                subtitle: Text("R\$ 12.345,67"),
              ),
            ),
            SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_upward, color: Colors.green),
                title: Text("Entradas"),
                subtitle: Text("R\$ 7.890,00"),
              ),
            ),
            SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_downward, color: Colors.red),
                title: Text("Saídas"),
                subtitle: Text("R\$ 5.432,00"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
