import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/theme/themeProvider.dart';

IconButton themeButton(WidgetRef ref) {
  final themeMode = ref.watch(themeControllerProvider);
  return IconButton(
    icon: Icon(
      themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
    ),
    onPressed: () => ref.read(themeControllerProvider.notifier).toggleTheme(),
  );
}