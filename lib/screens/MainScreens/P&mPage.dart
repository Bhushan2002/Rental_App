import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/widgets/MapWidget.dart';

class PackageAndMoversPage extends ConsumerWidget {
  const PackageAndMoversPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Package and Movers")),
    );
  }
}
