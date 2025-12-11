import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/models/UserModel.dart';
import 'package:rental_application/screens/MainScreens/MainNavBarScreen.dart';
import 'package:rental_application/screens/Owner/OwnerNavbarScreen.dart';
import 'package:rental_application/screens/auth/SignInPage.dart';

final authStateProvider = StreamProvider<User?>(
      (ref) => FirebaseAuth.instance.authStateChanges(),
);

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  Future<String?> _getUserRole(String uid) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return snapshot['role'] as String?;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          // not signed in
          return SignInPage(); // or Navigator.pushReplacementNamed
        } else {
          // signed in → check role
          return FutureBuilder<String?>(
            future: _getUserRole(user.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final role = snapshot.data;
              if (role == UserRole.owner.name) {
                return const OwnerNavbarScreen();
              } else if (role == UserRole.tenant.name) {
                return const MainNavigationScreen();
              } else {
                return Scaffold(
                  body: Center(child: Text('Unknown role, contact admin')),
                );
              }
            },
          );
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
