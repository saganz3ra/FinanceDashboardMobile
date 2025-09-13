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

- Estrutura completa baseada no Atomic Design:
  - Componentes organizados em `lib/shared/widgets/atoms`, `molecules`, `organisms`.
  - Telas principais refatoradas para usar atomic design, facilitando manutenção e reutilização.
- Extração e reutilização de componentes: campos, botões, listas e títulos agora são widgets reutilizáveis.
- Validações robustas nos formulários (Dashboard e Register): valor, descrição, data (com máscara e seleção), e duplicidade de transações.
- Integração com API de cotação do dólar:

  - O Dashboard exibe a cotação atual do dólar em tempo real, consumindo a API pública https://economia.awesomeapi.com.br/json/last/USD-BRL.
  - Conversão automática dos valores das transações para dólar.

- Registro de usuário com validação de todos os campos (incluindo máscara de data e confirmação de senha)
- Salvamento dos dados do registro localmente usando o pacote [`shared_preferences`](https://pub.dev/packages/shared_preferences), simulando um backend
- Login validando email e senha com os dados salvos localmente
- Dashboard com campo de data que aceita digitação e formata automaticamente com '/'
- Transições suaves entre telas
- Todos os controladores de formulário são corretamente descartados (dispose)

## 🚀 Estrutura

- Estrutura baseada no Atomic Design:
  - `lib/shared/widgets/atoms`: componentes básicos (inputs, botões)
  - `lib/shared/widgets/molecules`: combinações simples (cards, grupos de botões, campos agrupados)
  - `lib/shared/widgets/organisms`: blocos funcionais maiores (listas, formulários)
  - `lib/shared/widgets/templates`: reservado para templates de tela (ainda não utilizado)
  - Telas usam e compõem esses componentes para máxima reutilização e clareza.
- Navegação entre telas usando rotas nomeadas e transições animadas
- Layout moderno com `Scaffold`, `AppBar`, componentes customizados e responsivos

## 🔗 Como rodar

1. Clone o repositório
2. Rode `flutter pub get`
3. Execute `flutter run`

## 📦 Dependências externas

### API de Cotação do Dólar

O app consome a API pública [`AwesomeAPI`](https://docs.awesomeapi.com.br/api-de-moedas) para exibir a cotação do dólar em tempo real no Dashboard:

```
https://economia.awesomeapi.com.br/json/last/USD-BRL
```

Essa integração permite converter valores das transações para dólar automaticamente.

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
