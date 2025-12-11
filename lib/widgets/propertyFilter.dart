import 'package:flutter/material.dart';
import 'package:rental_application/models/PropFilterModel.dart';

class PropertyFilterWidget extends StatefulWidget {
  final Function(PropertyFilter) onApply;

  const PropertyFilterWidget({super.key, required this.onApply});

  @override
  State<PropertyFilterWidget> createState() => _PropertyFilterWidgetState();
}

class _PropertyFilterWidgetState extends State<PropertyFilterWidget> {
  double _minPrice = 5000;
  double _maxPrice = 50000;
  int? _bhk;
  String? _furnishing;

  final List<int> bhkOptions = [1, 2, 3, 4, 5];
  final List<String> furnishingOptions = [
    "Furnished",
    "Semi-Furnished",
    "Unfurnished",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 460,
      width: double.maxFinite,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Filter Properties",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 20),
          // Price Range
          const Text("Price Range"),
          RangeSlider(
            values: RangeValues(_minPrice as double, _maxPrice as double),
            min: 0,
            max: 100000,
            divisions: 100,
            labels: RangeLabels(
              "₹${_minPrice.toInt()}",
              "₹${_maxPrice.toInt()}",
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _minPrice = values.start as double;
                _maxPrice = values.end as double;
              });
            },
          ),

          const SizedBox(height: 20),
          // BHK Dropdown
          DropdownButtonFormField<int>(
            value: _bhk,
            decoration: const InputDecoration(labelText: "BHK"),
            items: bhkOptions
                .map((e) => DropdownMenuItem(value: e, child: Text("$e BHK")))
                .toList(),
            onChanged: (val) => setState(() => _bhk = val),
          ),

          const SizedBox(height: 20),

          // Furnishing Dropdown
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Furnishing",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Column(
            children: [
              RadioListTile<String>(
                title: const Text('Furnished'),
                value: 'Furnished',
                groupValue: _furnishing,
                onChanged: (val) => setState(() => _furnishing = val),
              ),
              RadioListTile<String>(
                title: const Text('Unfurnished'),
                value: 'Unfurnished',
                groupValue: _furnishing,
                onChanged: (val) => setState(() => _furnishing = val),
              ),
            ],
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.onApply(
                PropertyFilter(
                  minPrice: _minPrice as int,
                  maxPrice: _maxPrice as int ,
                  bhk: _bhk,
                  // furnishing: _furnishing as String,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text("Apply Filter"),
          ),
        ],
      ),
    );
  }
}
