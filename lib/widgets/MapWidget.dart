import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:rental_application/theme/themeProvider.dart';

class MapboxWidget extends ConsumerStatefulWidget {
  const MapboxWidget({super.key});

  @override
  ConsumerState createState() => _MapboxWidgetState();
}

class _MapboxWidgetState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: MapWidget(
        key: ValueKey("mapWidget"),
        cameraOptions: CameraOptions(
          zoom: 10,
          center: Point(coordinates: Position(73.8786, 18.5246)),
        ),
        styleUri: themeMode == ThemeMode.dark
            ? 'mapbox://styles/bhushan002/cmeqx95kk002y01sf7p5h1p55'
            : "mapbox://styles/bhushan002/cmeqxdzsb009401qt4tgrds1z",
        // mapOptions: MapOptions(pixelRatio: 5),
        // onMapCreated: ()=>{},
      ),
    );
  }
}
