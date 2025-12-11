import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_application/models/UserModel.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  Stream<User?> get authStateChangers => _firebaseAuth.authStateChanges();

  AuthRepository(this._firebaseAuth, this._firestore);

  Future<Usermodel?> getUserDetails(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return Usermodel.fromFirestore(doc);
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
    return null;
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
    required String phone,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      await _addUserDetails(
        uid: userCredential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        role: role,
        phone : phone
      );
    }
  }

  Future<void> _addUserDetails({
    required String uid,
    required String firstName,
    required String lastName,
    required String email,
    required String role,
    required String phone,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role':role,
      'phone': phone,
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
