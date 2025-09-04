# Projeto Mobile em Flutter

Este projeto é uma adaptação do sistema em Laravel para mobile, utilizando Flutter.

## 📱 Telas implementadas

- **HomePage**: Tela inicial com botões de navegação.
- **LoginPage**: Tela de login simples.
- **DashboardPage**: Tela de controle financeiro do usuário, agora com CRUD completo de transações.

## 🧾 Funcionalidades do Dashboard

- Adicionar, editar e excluir transações financeiras (entradas e saídas)
- Formulário centralizado e responsivo, estilo Google Forms
- Validação dos campos: valor, descrição e data
- Restrições de data:
  - Entradas não podem ser cadastradas com data futura
  - Saídas podem ser programadas para datas futuras
- Visualização de lista de transações, com ícones e informações detalhadas
- Botões reestilizados para maior contraste e melhor visualização

## 🚀 Estrutura

- Refatoração do código seguindo o padrão Atomic Design (componentes organizados em átomos, moléculas e organismos)
- Navegação entre telas usando rotas nomeadas
- Layout moderno com `Scaffold`, `AppBar`, componentes customizados e responsivos

## 🔗 Como rodar

1. Clone o repositório
2. Rode `flutter pub get`
3. Execute `flutter run`

## 📦 Dependências externas

Este projeto utiliza o pacote [`intl`](https://pub.dev/packages/intl) para manipulação e formatação de datas. Para instalar, execute:

```bash
flutter pub add intl
```

Caso utilize outros pacotes que não vêm por padrão em projetos Flutter, instale-os também usando o comando `flutter pub add <nome_do_pacote>`.
