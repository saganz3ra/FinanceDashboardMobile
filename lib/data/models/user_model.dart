import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.cpf,
    required super.email,
    required super.password,
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
}
