import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/models/UserModel.dart';
import 'package:rental_application/screens/MainScreens/MainNavBarScreen.dart';
import 'package:rental_application/screens/Owner/OwnerNavbarScreen.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    await Future.delayed(const Duration(seconds: 1)); // splash delay

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // if not logged in, send back to sign-in
      Navigator.pushReplacementNamed(context, '/signin');
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      if (snapshot.exists) {
        final data = snapshot.data()!;
        final role = data['role'];

        if (role == UserRole.owner.name) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OwnerNavbarScreen()),
          );
        } else if (role == UserRole.tenant.name) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
          );
        } else {
          // unknown role
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unknown role, contact admin')),
          );
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User data not found')));
      }
    } catch (e) {
      print("Error fetching user role: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome!",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
