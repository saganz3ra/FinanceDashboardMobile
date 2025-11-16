/// Entidade de domínio representando um usuário.
/// Não contém detalhes de infraestrutura como senha (mantida apenas no Model).
class User {
  final String name;
  final String cpf;
  final String email;
  final String phone;
  final String birthDate;

  const User({
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.birthDate,
  });
}
