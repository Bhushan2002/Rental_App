import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';

class Customdrawer extends ConsumerWidget {
  const Customdrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/house-keys.jpg'),
                fit: BoxFit.contain,
                opacity: 0.9,
              ),
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_repair_service),
            title: Text(
              'Services',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              // Add navigation or logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.gavel),
            title: Text(
              'Legal Assistance and Loan',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              // Add navigation or logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text(
              'Help and Support',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              // Add navigation or logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.real_estate_agent),
            title: Text(
              'Request to post Property',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}
