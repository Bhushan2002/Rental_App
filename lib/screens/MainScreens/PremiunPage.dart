import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/theme/themeProvider.dart';

class PrimiumPage extends ConsumerWidget {
  const PrimiumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    return const Placeholder(child: Text('Primium page.'));
  }
}
