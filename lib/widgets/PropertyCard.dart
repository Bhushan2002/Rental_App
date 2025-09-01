import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String address;
  final int baths;
  final int beds;
  final int bhk;
  // final VoidCallback onScheduleTour;

  const PropertyCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.address,
    required this.baths,
    required this.beds,
    required this.bhk,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Popular",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.white54,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border, color: Colors.red),
                  ),
                ),
              ),
              // Details over image
              Positioned(
                bottom: 10,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _infoChip("$baths baths"),
                    _infoChip("$beds beds"),
                    _infoChip("$bhk BHK"),
                  ],
                ),
              ),
            ],
          ),
          // Price and address
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
                Text(
                  '₹ $price',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(address, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for chips
  Widget _infoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
