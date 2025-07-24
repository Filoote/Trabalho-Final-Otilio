import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController {
  final Set<Marker> markers = {};

  void addMarker(LatLng position, BuildContext context) {
    final markerId = MarkerId('marker_${markers.length}');
    markers.add(
      Marker(
        markerId: markerId,
        position: position,
        infoWindow: InfoWindow(
          title: 'Marcador ${markers.length + 1}',
          snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }
}