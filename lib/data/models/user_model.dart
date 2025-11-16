import '../../domain/entities/user.dart';

/// Model de dados que estende a entidade User.
/// Contém o campo password para persistência, que não faz parte da entidade de domínio.
class UserModel extends User {
  final String password;

  const UserModel({
    required super.name,
    required super.cpf,
    required super.email,
    required this.password,
    required super.phone,
    required super.birthDate,
  });

  factory UserModel.fromMap(Map<String, String> map) {
    return UserModel(
      name: map['name'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      birthDate: map['birthDate'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'cpf': cpf,
      'email': email,
      'password': password,
      'phone': phone,
      'birthDate': birthDate,
    };
  }

  /// Converte o Model para a Entity de domínio (sem password)
  User toEntity() {
    return User(
      name: name,
      cpf: cpf,
      email: email,
      phone: phone,
      birthDate: birthDate,
    );
  }

  /// Cria um UserModel a partir de uma Entity e senha
  factory UserModel.fromEntity(User user, String password) {
    return UserModel(
      name: user.name,
      cpf: user.cpf,
      email: user.email,
      password: password,
      phone: user.phone,
      birthDate: user.birthDate,
    );
  }
}
