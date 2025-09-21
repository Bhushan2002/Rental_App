import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/PropertyData/property_controller.dart';

import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/screens/MainScreens/ChatBotScreen.dart';
import 'package:rental_application/screens/Owner/UpdatePropertyPage.dart';
import 'package:rental_application/theme/themeProvider.dart';
import 'package:rental_application/widgets/CustomDrawer.dart';
import 'package:rental_application/widgets/FullMap.dart';
import 'package:rental_application/widgets/PropertyCard.dart';
import 'package:rental_application/widgets/SearchProperty.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(getAllPropertiesProvider);
    final userDetails = ref.watch(userDetailsProvider);

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
                          MaterialPageRoute(builder: (context) => FullMap()),
                        );
                      },
                      icon: Icon(Icons.map_outlined),
                      tooltip: 'View Map',
                    ),
                  ],
                ),
              ),

              themeButton(ref),
            ],
          ),
          drawer: Customdrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                PropertySearchCard(),
                SizedBox(height: 10),
                properties.when(
                  data: (property) {
                    if (property.isEmpty) {
                      return Center(child: Text("No properties available"));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: property.length,
                      itemBuilder: (context, index) {
                        final prop = property[index];
                        final address = '${prop.street}, ${prop.city}';
                        return InkWell(
                          child: PropertyCard(
                            title: prop.title,
                            imageUrl: prop.images.isNotEmpty
                                ? prop.images[0]
                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcCBHgbS23kyBw2r8Pquu19UtKZnrZmFUx1g&s",
                            price: prop.price,
                            address: address,
                            baths: prop.bathrooms,
                            beds: prop.bedrooms,
                            bhk: prop.bhk,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdatePropertyPage(property: prop),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  error: (err, stk) => Text('Error: $err'),
                  loading: () => Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatbotScreen()),
              );
            },
            child: const Icon(Icons.chat),
          ),
        );
      },
      error: (err, stack) => Text('$err'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

IconButton themeButton(WidgetRef ref) {
  final themeMode = ref.watch(themeControllerProvider);
  return IconButton(
    icon: Icon(
      themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
    ),
    onPressed: () => ref.read(themeControllerProvider.notifier).toggleTheme(),
  );
}
