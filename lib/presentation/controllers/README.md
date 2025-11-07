Exemplo: usar Provider + ChangeNotifier para gerenciar estado do Dashboard

Trecho mínimo (para documentação):

1) Controller (já implementado em `lib/presentation/controllers/dashboard_controller.dart`)

2) Como fornecer o controller para a UI (exemplo a ser usado na tela `DashboardPage`):

```dart
import 'package:provider/provider.dart';
import 'package:financedashboard/presentation/controllers/dashboard_controller.dart';

// dentro do build do Widget de nível superior (ex.: na rota que cria DashboardPage)
return ChangeNotifierProvider<DashboardController>(
  create: (_) {
    final controller = DashboardController();
    controller.loadAll(); // carrega dados inicial
    return controller;
  },
  child: DashboardPage(),
);
```

3) Como consumir o estado na UI (exemplo pequeno dentro de `DashboardPage`):

```dart
// obtém o controller
final controller = Provider.of<DashboardController>(context);
// ou com Consumer/Selector para otimizações

// exibir valor do dólar
if (controller.isLoading) {
  return const CircularProgressIndicator();
}
if (controller.error != null) {
  return Text('Erro: ${controller.error}');
}
Text('1 USD = R\$ ${controller.dollarValue?.toStringAsFixed(2) ?? '-'}');

// exibir lista de transações
ListView.builder(
  itemCount: controller.transactions.length,
  itemBuilder: (context, i) {
    final t = controller.transactions[i];
    // ... montar item
  },
);
```

Observações:
- O `DashboardController` encapsula a lógica de refresh/add/edit/delete e pode ser testado isoladamente.
- Mantendo `ChangeNotifier` separado da UI, você reduz acoplamento e melhora testabilidade.
- Para aplicações maiores, considere `StateNotifier` (Riverpod) ou `Bloc` para features com mais complexidade.
