import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dio/dio.dart';

import '../Models/directions_model.dart';

class LocationService {
  static const String directionsUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  String api_key = "AIzaSyCnLR6Xxni4eXS_Ya3rYoo8zG8qwX78Fzc";
  final Dio _dio;

  LocationService({Dio? dio}) : _dio = dio ?? Dio();

  Future<Position> currentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    //TODO: use stream to get currentPosition faster
    Geolocator.getPositionStream();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Future<LocationData> getCurrentLocation() async {
  //   Location _locationTracker = Location();
  //   try {
  //     var currentLocation = await _locationTracker.getLocation();
  //     print(currentLocation.altitude);
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       debugPrint("Permission Denied");
  //       // currentLocation = null;
  //     }
  //     // return currentLocation;
  //   }
  // }
  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      directionsUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': api_key,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      print(response.statusCode);
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
// {
//    "plus_code" : {
//       "compound_code" : "P27Q+MC New York, NY, USA",
//       "global_code" : "87G8P27Q+MC"
//    },
//    "results" : [
//       {
//          "address_components" : [
//             {
//                "long_name" : "279",
//                "short_name" : "279",
//                "types" : [ "street_number" ]
//             },
//             {
//                "long_name" : "Bedford Avenue",
//                "short_name" : "Bedford Ave",
//                "types" : [ "route" ]
//             },
//             {
//                "long_name" : "Williamsburg",
//                "short_name" : "Williamsburg",
//                "types" : [ "neighborhood", "political" ]
//             },
//             {
//                "long_name" : "Brooklyn",
//                "short_name" : "Brooklyn",
//                "types" : [ "political", "sublocality", "sublocality_level_1" ]
//             },
//             {
//                "long_name" : "Kings County",
//                "short_name" : "Kings County",
//                "types" : [ "administrative_area_level_2", "political" ]
//             },
//             {
//                "long_name" : "New York",
//                "short_name" : "NY",
//                "types" : [ "administrative_area_level_1", "political" ]
//             },
//             {
//                "long_name" : "United States",
//                "short_name" : "US",
//                "types" : [ "country", "political" ]
//             },
//             {
//                "long_name" : "11211",
//                "short_name" : "11211",
//                "types" : [ "postal_code" ]
//             }
//          ],
//          "formatted_address" : "279 Bedford Ave, Brooklyn, NY 11211, USA",
//          "geometry" : {
//             "location" : {
//                "lat" : 40.7142484,
//                "lng" : -73.9614103
//             },
//             "location_type" : "ROOFTOP",
//             "viewport" : {
//                "northeast" : {
//                   "lat" : 40.71559738029149,
//                   "lng" : -73.9600613197085
//                },
//                "southwest" : {
//                   "lat" : 40.71289941970849,
//                   "lng" : -73.96275928029151
//                }
//             }
//          },
//          "place_id" : "ChIJT2x8Q2BZwokRpBu2jUzX3dE",
//          "plus_code" : {
//             "compound_code" : "P27Q+MC Brooklyn, New York, United States",
//             "global_code" : "87G8P27Q+MC"
//          },
//          "types" : [
//             "bakery",
//             "cafe",
//             "establishment",
//             "food",
//             "point_of_interest",
//             "store"
//          ]
//       },

//    ... Additional results truncated in this example[] ...

//    ],
//    "status" : "OK"
// }
