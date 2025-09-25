import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:rental_application/models/PropertyModel.dart';
import 'package:rental_application/screens/Owner/UpdatePropertyPage.dart';
import 'package:rental_application/theme/themeProvider.dart';
import 'package:rental_application/PropertyData/property_controller.dart';

// Helper class to implement the click listener
class _MyPointAnnotationClickListener
    implements OnPointAnnotationClickListener {
  final Function(PointAnnotation) onAnnotationClicked;

  _MyPointAnnotationClickListener(this.onAnnotationClicked);

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onAnnotationClicked(annotation);
  }
}

class FullMap extends ConsumerStatefulWidget {
  const FullMap({super.key});

  @override
  ConsumerState createState() => _FullMapState();
}

class _FullMapState extends ConsumerState<FullMap> {
  Property? _selectedProperty;
  MapboxMap? _mapboxMap;
  final TextEditingController _searchController = TextEditingController();
  bool _isMapReady = false; // Flag to track if the map is ready

  // Simple map for city coordinates
  final Map<String, Position> _cityCoordinates = {
    'pune': Position(73.8567, 18.5204),
    'mumbai': Position(72.8777, 19.0760),
    'bangalore': Position(77.5946, 12.9716),
    'delhi': Position(77.2090, 28.6139),
  };

  void _searchCity(String cityName) {
    final city = cityName.toLowerCase().trim();
    if (_cityCoordinates.containsKey(city)) {
      final coordinates = _cityCoordinates[city]!;
      _mapboxMap?.flyTo(
        CameraOptions(center: Point(coordinates: coordinates), zoom: 10),
        MapAnimationOptions(duration: 1500), // Animate over 1.5 seconds
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('City not found. Try Pune, Mumbai, etc.')),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);
    final propertiesAsyncValue = ref.watch(getAllPropertiesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Search Map')),
      body: propertiesAsyncValue.when(
        data: (properties) {
          return Stack(
            children: [
              MapWidget(
                key: const ValueKey("mapWidget"),
                androidHostingMode: AndroidPlatformViewHostingMode.TLHC_HC,
                cameraOptions: CameraOptions(
                  zoom: 10,
                  center: Point(
                    coordinates: Position(
                      73.8567, // Default to Pune
                      18.5204,
                    ),
                  ),
                ),
                styleUri: themeMode == ThemeMode.dark
                    ? MapboxStyles.DARK
                    : MapboxStyles.LIGHT,
                onMapCreated: (mapboxMap) {
                  _mapboxMap = mapboxMap;
                  // Once the map is created, set the flag to true and rebuild
                  setState(() {
                    _isMapReady = true;
                  });
                  _onMapCreated(mapboxMap, properties);
                },
              ),
              Positioned(
                top: 10,
                left: 15,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: themeMode == ThemeMode.dark
                        ? Colors.grey[800]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    // Enable/disable the text field based on the map's readiness
                    enabled: _isMapReady,
                    decoration: InputDecoration(
                      // Change hint text based on the map's readiness
                      hintText: _isMapReady
                          ? 'Search for a city...'
                          : 'Map is loading...',
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                    ),
                    onSubmitted: (value) {
                      _searchCity(value);
                    },
                  ),
                ),
              ),
              if (_selectedProperty != null)
                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              UpdatePropertyPage(property: _selectedProperty!),
                        ),
                      );
                    },
                    child: Card(
                      color: themeMode == ThemeMode.dark
                          ? Colors.black45
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedProperty!.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₹ ${_selectedProperty!.price}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "${_selectedProperty!.street}, ${_selectedProperty!.city}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _onMapCreated(
    MapboxMap mapboxMap,
    List<Property> properties,
  ) async {
    final pointAnnotationManager = await mapboxMap.annotations
        .createPointAnnotationManager();

    final ByteData bytes = await rootBundle.load("assets/images/location.png");
    final Uint8List markerImage = bytes.buffer.asUint8List();

    final List<PointAnnotationOptions> options = [];
    for (final property in properties) {
      if (property.coordinates != null) {
        options.add(
          PointAnnotationOptions(
            geometry: Point(
              coordinates: Position(
                property.coordinates!.lon,
                property.coordinates!.lat,
              ),
            ),
            image: markerImage,
            iconSize: 0.5,
          ),
        );
      }
    }

    final annotations = await pointAnnotationManager.createMulti(options);

    pointAnnotationManager.addOnPointAnnotationClickListener(
      _MyPointAnnotationClickListener((clickedAnnotation) {
        for (var i = 0; i < annotations.length; i++) {
          if (annotations[i]!.id == clickedAnnotation.id) {
            setState(() {
              _selectedProperty = properties[i];
            });
            break;
          }
        }
      }),
    );
  }
}
