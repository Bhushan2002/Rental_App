import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/theme/themeProvider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    return AppBar(
      title: Text("Rental Houses"),
      actions: [
        IconButton(
          icon: Icon(
            themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () =>
              ref.read(themeControllerProvider.notifier).toggleTheme(),
        ),
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'signout') {
              await ref.read(authControllerProvider.notifier).signOut();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'Profile', child: Text('Profile')),
            PopupMenuItem(value: 'setting', child: Text('Settings')),
            PopupMenuItem(value: 'signout', child: Text('Sign Out')),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
