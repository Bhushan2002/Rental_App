import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/theme/themeProvider.dart';
import 'package:rental_application/widgets/CustomNavbar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(userDetailsProvider);

    return userDetails.when(
      data: (user) {
        if (user == null) {
          return Text("User data not found.");
        }
        return Scaffold(
          appBar: CustomAppBar(),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
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
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome, ${user.firstName} ${user.lastName}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text("Email: ${user.email}"),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
      error: (err, stack) => Text('$err'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
