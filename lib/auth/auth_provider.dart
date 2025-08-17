import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_controller.dart';
import 'package:rental_application/auth/auth_repository.dart';
import 'package:rental_application/models/UserModel.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
final fireStoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.watch(firebaseAuthProvider),
    ref.watch(fireStoreProvider),
  ),
);

final authStateChangesProvide = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChangers,
);

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(ref.watch(authRepositoryProvider));
});

final userDetailsProvider = FutureProvider<Usermodel?>((ref) {
  final authState = ref.watch(authStateChangesProvide).value;
  if (authState != null) {
    return ref.watch(authRepositoryProvider).getUserDetails(authState.uid);
  }
  return null;
});
