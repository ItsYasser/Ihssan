import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    // if ((map['routes'] as List).isEmpty) return null;

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    return Directions(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
    );
  }
}
