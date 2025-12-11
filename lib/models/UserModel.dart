import 'package:cloud_firestore/cloud_firestore.dart';


enum UserRole {tenant, owner}
class Usermodel {
  final String uid;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String role;
  Usermodel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.role
  });
  factory Usermodel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Usermodel(
      uid: doc.id,
      firstName: data['firstName'] ?? '',

      lastName: data['lastName'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'tenant',
    );
  }
}
