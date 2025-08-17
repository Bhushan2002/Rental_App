import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;

  Usermodel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  factory Usermodel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Usermodel(
      uid: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
