import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel?> signIn(String email, String password);
  Future<AuthUserModel?> signUp(String email, String password, {String? displayName});
  Future<void> signOut();
  Future<AuthUserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fb.FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<AuthUserModel?> signIn(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final user = result.user;
    if (user == null) return null;
    return AuthUserModel.fromFirebaseUser(user);
  }

  @override
  Future<AuthUserModel?> signUp(String email, String password, {String? displayName}) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final user = result.user;
    if (user == null) return null;
    if (displayName != null) await user.updateDisplayName(displayName);
    return AuthUserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AuthUserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;
    return AuthUserModel.fromFirebaseUser(user);
  }
}

// Fallback implementation used during debugging when Firebase is not available.
class AuthRemoteDataSourceFallback implements AuthRemoteDataSource {
  const AuthRemoteDataSourceFallback();

  @override
  Future<AuthUserModel?> getCurrentUser() async {
    return null;
  }

  @override
  Future<AuthUserModel?> signIn(String email, String password) async {
    throw Exception('Auth not available in this environment (fallback).');
  }

  @override
  Future<void> signOut() async {
    // no-op
  }

  @override
  Future<AuthUserModel?> signUp(String email, String password, {String? displayName}) async {
    throw Exception('Auth not available in this environment (fallback).');
  }
}
