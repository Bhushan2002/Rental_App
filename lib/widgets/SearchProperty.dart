import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PropertySearchCard extends StatelessWidget {
  const PropertySearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final textColor = isDarkMode ? Colors.white70 : Colors.black54;

    final List<String> cities = [
      'Pune',
      'Mumbai',
      'Bangalore',
      'Chennai',
      'Delhi',
    ];

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
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
                    tabs: [
                      Tab(text: 'Flats'),
                      Tab(text: 'Houses'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TypeAheadField(
                  // ...
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      // obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Search Localities or Landmarks',
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: textColor),
                        filled: false,
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
                    );
                  },
                  itemBuilder: (BuildContext context, value) {
                    return ListTile(title: Text(value.toString()));
                  },
                  onSelected: (value) {},
                  suggestionsCallback: (String search) {
                    return cities
                        .where(
                          (city) => city.toLowerCase().startsWith(
                            search.toLowerCase(),
                          ),
                        )
                        .toList();
                  },
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
