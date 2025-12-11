import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/data/PropertyData/property_controller.dart';

import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/screens/Owner/PropertyList.dart';
import 'package:rental_application/widgets/SearchProperty.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(getAllPropertiesProvider);
    final userDetails = ref.watch(userDetailsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [PropertySearchCard(), PropertyList()]),
      ),
    );
  }
}
