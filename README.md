# FinanceDashboardMobile (Flutter)

App mobile de controle financeiro pessoal, escrito em Flutter, com arquitetura limpa (Domain/Data/Presentation), estado global com Provider/ChangeNotifier e DI com GetIt. Integra Firebase Core e prepara Firestore; autenticação está temporariamente em bypass para facilitar o desenvolvimento.

• Flutter: 3.35.x • Dart: 3.9.x

## ✨ Principais funcionalidades

- Dashboard com CRUD de transações (entrada/saída) e validações de valor, descrição e data
- Conversão opcional para USD usando a API pública da AwesomeAPI (cotação do dólar)
- Formulários de Login e Registro com validações (nome, CPF, email, senha forte, telefone e data de nascimento)
- Componentização seguindo Atomic Design (atoms/molecules/organisms)
- Transições animadas e UI responsiva/semântica

## 🧩 Arquitetura e camadas

O projeto segue um desenho em camadas, favorecendo testabilidade e manutenção:

- domain/
  - entities/ (modelos de negócio puros)
  - repositories/ (abstrações)
  - usecases/ (regras de aplicação, ex.: `GetTransactions`, `GetDollarValue`)
- data/
  - models/ (DTOs e conversões)
  - datasources/ (remote/local: HTTP/AwesomeAPI, SharedPreferences, Firestore preparado)
  - repositories/ (implementações de `domain/repositories`)
- presentation/
  - controllers/ (ChangeNotifiers como `DashboardController` e `AuthController`)
- screens/ (telas: Home, Login, Register, Dashboard)
- shared/widgets (atoms, molecules, organisms)
- routes/ (mapeamento de rotas nomeadas)
- di/ (registro de dependências com GetIt)

Estado global: Provider/ChangeNotifier

DI: GetIt (ver `lib/di/injection_container.dart`)

## 📂 Estrutura de pastas (resumo)

```
lib/
  core/
  data/
    datasources/
    models/
    repositories/
  domain/
    entities/
    repositories/
    usecases/
  di/
  presentation/
    controllers/
  routes/
  screens/
  shared/
    constants/
    theme/
    widgets/
      atoms/
      molecules/
      organisms/
  widgets/
```

## 🔧 Pré‑requisitos

- Flutter SDK instalado (canal stable)
- Android Studio/Xcode configurados (para builds nativos) ou Chrome (para Web)
- Firebase já inicializado via `firebase_options.dart` (o projeto inclui os arquivos de plataforma)

## 🚀 Como executar

No terminal, dentro da pasta do projeto:

```powershell
# Instale dependências
flutter pub get

# Execute no dispositivo/simulador conectado
flutter run

# (Opcional) Rode para Web
flutter run -d chrome
```

Rotas principais:

- `/` → Home
- `/login` → Login
- `/register` → Registro
- `/dashboard` → Dashboard

## 🧪 Testes

O projeto possui testes unitários (models, controllers, repositórios) e de widget.

```powershell
flutter test
```

Pastas relevantes:

- `test/unit/models`
- `test/unit/controllers`
- `test/unit/repositories`
- `test/widget`

## 🌐 Integrações externas

### Cotação do dólar (AwesomeAPI)

Usamos a rota pública para obter a cotação do USD em BRL e exibir no Dashboard, além de calcular equivalentes:

```
https://economia.awesomeapi.com.br/json/last/USD-BRL
```

Implementação: `data/datasources/remote/currency_remote_data_source.dart` → `data/repositories/currency_repository_impl.dart` → `domain/usecases/get_dollar_value.dart`.

### Firebase

- `firebase_core` inicializado em `main.dart`
- Firestore disponível e data source registrado (ver `TransactionFirestoreDataSource`), porém o repositório de transações padrão atualmente usa armazenamento local para facilitar o desenvolvimento.
- Autenticação está em bypass temporário (ver `presentation/controllers/auth_controller.dart`).

Para reativar a autenticação real (Firebase Auth):

1) Reintroduza os imports e registros de Auth no `lib/di/injection_container.dart` (datasource, repositório e usecases de signIn/signUp/signOut)
2) Atualize `AuthController` para chamar os usecases reais
3) Ajuste `LoginPage`/`RegisterPage` para usar o `AuthController` (Provider)

## 🧱 Decisões de engenharia

- Provider/ChangeNotifier para simplicidade e boa integração com Flutter
- GetIt para DI explícita e testável
- Clean Architecture para separar responsabilidade e permitir mocks em testes
- Widgets com semântica e acessibilidade (ex.: `Semantics` em botões)

## 🧹 Lint, qualidade e formatação

- Regras no `analysis_options.yaml`
- Análise estática:

```powershell
flutter analyze
```

- Formatação:

```powershell
dart format .
```

## 🐞 Solução de problemas

- Erro ao inicializar Firebase: confira `firebase_options.dart` e os arquivos nativos (Google Services / plist)
- Problemas de rota: verifique `lib/routes/app_routes.dart`
- Sem internet: a cotação do dólar não será atualizada; transações locais continuam funcionando

## 📜 Licença

Este repositório é apenas para fins educacionais/demonstração. Defina sua licença conforme necessário.

