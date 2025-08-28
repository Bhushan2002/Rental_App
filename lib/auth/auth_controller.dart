import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_repository.dart';
import 'package:rental_application/models/UserModel.dart';

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  AuthController(this._authRepository) : super(false);

  Future<void> signInWithEmail({
    required String email,
    required String password,
    required Function(String) onError,
    required UserRole role,
  }) async {
    state = true;
    try {
      await _authRepository.signInWithEmail(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      onError(_mapAuthError(e));
    } finally {
      state = false;
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
    required Function(String) onError,
  }) async {
    state = true;
    try {
      await _authRepository.signUpWithEmail(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        role: role
      );
    } on FirebaseAuthException catch (e) {
      onError(_mapAuthError(e));
    } finally {
      state = false;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
