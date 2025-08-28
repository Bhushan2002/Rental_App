import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';
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

    // Delay navigation for 1 second
    Future.delayed(const Duration(seconds: 1), () {
      final userDetails = ref.read(userDetailsProvider);

      if (!mounted) return; // avoid calling Navigator after widget disposed

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (userDetails.value?.role == 'owner') {
              return const OwnerNavbarScreen();
            } else if (userDetails.value?.role == 'tenant') {
              return const MainNavigationScreen();
            }
            return CircularProgressIndicator();
          },
        ),
      );
    });
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
