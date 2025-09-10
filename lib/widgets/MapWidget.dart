import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:rental_application/theme/themeProvider.dart';

class MapboxWidget extends ConsumerStatefulWidget {
  final double latitude;
  final double longitute;
  const MapboxWidget({
    super.key,
    required this.latitude,
    required this.longitute,
  });

  @override
  ConsumerState createState() => _MapboxWidgetState();
}

class _MapboxWidgetState extends ConsumerState<MapboxWidget> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);

    return MapWidget(
      key: const ValueKey("mapWidget"),
      androidHostingMode: AndroidPlatformViewHostingMode.TLHC_HC,
      cameraOptions: CameraOptions(
        zoom: 17,
        center: Point(coordinates: Position(widget.longitute, widget.latitude)),
      ),
      styleUri: themeMode == ThemeMode.dark
          ? 'mapbox://styles/bhushan002/cmeqx95kk002y01sf7p5h1p55'
          : "mapbox://styles/bhushan002/cmeqxdzsb009401qt4tgrds1z",
      // styleUri: MapboxStyles.MAPBOX_STREETS,
      onMapCreated: _onMapCreated,
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    // Create annotation manager
    final annotationManager = await mapboxMap.annotations
        .createPointAnnotationManager();
    _pointAnnotationManager = annotationManager;

    // Load marker image (from assets)
    final ByteData bytes = await rootBundle.load(
      "assets/images/pin.png",
    ); // <- add your pin icon in assets
    final Uint8List markerImage = bytes.buffer.asUint8List();

    // Create annotation options
    var options = PointAnnotationOptions(
      geometry: Point(coordinates: Position(widget.longitute, widget.latitude)),
      image: markerImage,
      iconSize: 0.5, // adjust size if needed
    );

    // Add annotation (marker)
    await annotationManager.create(options);
  }
}
