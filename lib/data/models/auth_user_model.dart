import '../../domain/entities/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class AuthUserModel extends AuthUser {
  AuthUserModel({required super.uid, required super.email, super.displayName});

  factory AuthUserModel.fromFirebaseUser(fb.User user) {
    return AuthUserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }
}
