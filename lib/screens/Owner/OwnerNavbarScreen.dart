import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rental_application/screens/MainScreens/MyBooking.dart';
import 'package:rental_application/screens/MainScreens/P&mPage.dart';
import 'package:rental_application/screens/MainScreens/PremiunPage.dart';
import 'package:rental_application/screens/Owner/OwnerProperties.dart';
import 'package:rental_application/screens/Owner/PropertyForm.dart';
import 'package:rental_application/theme/themeProvider.dart';
import 'package:rental_application/widgets/MapWidget.dart';

class OwnerNavbarScreen extends ConsumerStatefulWidget {
  const OwnerNavbarScreen({super.key});

  @override
  ConsumerState createState() => _OwnerNavbarScreenState();
}

class _OwnerNavbarScreenState extends ConsumerState<OwnerNavbarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Ownerproperties(),
    PostPropertyForm(),
    MyBookingPage(),
    PrimiumPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);
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
                      MaterialPageRoute(builder: (context) => MapboxWidget()),
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
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () =>
                ref.read(themeControllerProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 7,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.create_new_folder),
            label: 'properties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'My Booking',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Plus Plan'),
        ],
      ),
    );
  }
}
