# FinanceDashboardMobile

Este projeto é uma adaptação do sistema em Laravel para mobile, utilizando Flutter.

## 📱 Telas implementadas

- **HomePage**: Tela inicial com botões de navegação.
- **LoginPage**: Tela de login com autenticação local simulada.
- **RegisterPage**: Tela de registro com validação completa (nome, CPF, email, senha forte, confirmação de senha, telefone, data de nascimento com máscara e seleção por calendário).
- **DashboardPage**: Tela de controle financeiro do usuário, com CRUD completo de transações e campo de data com máscara.

## 🧾 Funcionalidades do Dashboard

- Adicionar, editar e excluir transações financeiras (entradas e saídas)
- Formulário centralizado e responsivo, estilo Google Forms
- Validação dos campos: valor, descrição e data
- Restrições de data:
  - Entradas não podem ser cadastradas com data futura
  - Saídas podem ser programadas para datas futuras
- Visualização de lista de transações, com ícones e informações detalhadas
- Botões reestilizados para maior contraste e melhor visualização

## 🆕 Funcionalidades recentes

- Registro de usuário com validação de todos os campos (incluindo máscara de data e confirmação de senha)
- Salvamento dos dados do registro localmente usando o pacote [`shared_preferences`](https://pub.dev/packages/shared_preferences), simulando um backend
- Login validando email e senha com os dados salvos localmente
- Dashboard com campo de data que aceita digitação e formata automaticamente com '/'
- Transições suaves entre telas
- Todos os controladores de formulário são corretamente descartados (dispose)

## 🚀 Estrutura

- Estrutura inspirada no Atomic Design (pasta `atoms` já implementada; demais níveis podem ser expandidos)
- Navegação entre telas usando rotas nomeadas e transições animadas
- Layout moderno com `Scaffold`, `AppBar`, componentes customizados e responsivos

## 🔗 Como rodar

1. Clone o repositório
2. Rode `flutter pub get`
3. Execute `flutter run`

## 📦 Dependências externas

### Destaque: [`shared_preferences`](https://pub.dev/packages/shared_preferences)

Utilizado para salvar e recuperar os dados do usuário localmente, simulando autenticação e persistência sem backend.

Para instalar:

```bash
flutter pub add shared_preferences
```

### Outras dependências

- [`intl`](https://pub.dev/packages/intl): manipulação e formatação de datas
- [`google_fonts`](https://pub.dev/packages/google_fonts): fontes customizadas
- [`cupertino_icons`](https://pub.dev/packages/cupertino_icons): ícones iOS

Caso utilize outros pacotes, instale-os usando:

```bash
flutter pub add <nome_do_pacote>
```
