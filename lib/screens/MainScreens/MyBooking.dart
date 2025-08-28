import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';

class MyBookingPage extends ConsumerStatefulWidget {
  const MyBookingPage({super.key});

  @override
  ConsumerState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends ConsumerState {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          ref.read(authControllerProvider.notifier).signOut();
        }, child: Text("signout")),
      )
    );
  }
}
