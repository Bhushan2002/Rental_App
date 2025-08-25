import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rental_application/screens/MainScreens/HomScreen.dart';
import 'package:rental_application/screens/MainScreens/MyBooking.dart';
import 'package:rental_application/screens/MainScreens/P&mPage.dart';
import 'package:rental_application/screens/MainScreens/PremiunPage.dart';
import 'package:rental_application/widgets/MapWidget.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(), // Home/properties
    PackageAndMoversPage(),
    // MapboxWidget(),
    MyBookingPage(),
    PrimiumPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 7,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Properties'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Packers & Movers',
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
