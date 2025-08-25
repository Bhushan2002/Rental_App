import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/theme/themeProvider.dart';
import 'package:rental_application/widgets/MapWidget.dart';

import 'package:rental_application/widgets/SearchProperty.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(userDetailsProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return userDetails.when(
      data: (user) {
        if (user == null) {
          return Text("User data not found.");
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Rental Houses"),
            actions: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapboxWidget(),
                          ),
                        );
                      },
                      icon: Icon(Icons.location_on),
                    ),
                    Text('Pune'),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () =>
                    ref.read(themeControllerProvider.notifier).toggleTheme(),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1713275324364-163352ffa175?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      ),
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
                  title: Text('Services'),
                  onTap: () {
                    // Add navigation or logic here
                  },
                ),
                ListTile(
                  leading: Icon(Icons.gavel),
                  title: Text('Legal Assistance and Loan'),
                  onTap: () {
                    // Add navigation or logic here
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Help and Support'),
                  onTap: () {
                    // Add navigation or logic here
                  },
                ),
                ListTile(
                  leading: Icon(Icons.real_estate_agent),
                  title: Text('Request to post Property'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    ref.read(authControllerProvider.notifier).signOut();
                    // Add navigation or logic here
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [PropertySearchCard()]),
          ),
        );
      },
      error: (err, stack) => Text('$err'),
      loading: () => Center(child: const CircularProgressIndicator()),
    );
  }
}
