import 'package:flutter/material.dart';

class PropertySearchCard extends StatelessWidget {
  const PropertySearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final textColor = isDarkMode ? Colors.white70 : Colors.black54;
    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
        child: Card(
          elevation: 2,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.blue[700],
                    unselectedLabelColor: textColor,
                    indicatorColor: Colors.blue[700],
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                    tabs: const [
                      Tab(text: 'Flats'),
                      Tab(text: 'Houses'),
                      Tab(text: 'PGs'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Localities or Landmarks',
                    hintStyle: TextStyle(color: textColor),
                    filled: false, // We use the card's color instead
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.blue[900]!,
                        width: 1,
                      ),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
