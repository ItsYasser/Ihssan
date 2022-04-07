import 'package:flutter_festival/Models/organisation_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/directions_model.dart';
import '../Models/person_model.dart';
import '../Util/functions.dart';
import '../Util/location.dart';
import '../Util/location_services.dart';

class DataController extends GetxController {
  List<Organizer> listOrganizer = [];
  List<Person> listPerson = [];
  List<Organizer> filteredListOrganizer = [];
  List<Person> filteredListPerson = [];

  void updateList(String query, bool isPerson) {
    print(query);
    if (isPerson) {
      filteredListPerson = listPerson
          .where((element) => element.name!.removeAllWhitespace
              .contains(query.removeAllWhitespace))
          .toList();
    } else {
      filteredListOrganizer = listOrganizer
          .where((element) => element.name!.removeAllWhitespace
              .contains(query.removeAllWhitespace))
          .toList();
    }

    update();
  }

  List<dynamic> getList(bool isPerson) {
    List<dynamic> temp = [];
    if (!isPerson) {
      temp = filteredListOrganizer;
    } else {
      temp = filteredListPerson;
    }
    return temp;
  }

  LatLng currentPosition = LatLng(0, 0);
  Directions? directions;
  void draw(LatLng pos) async {
    myDialog("يتم الان رسم المسار , الرجاء الانتظار");
    //get current locaton
    Position current = await determinePosition();
    currentPosition = LatLng(current.latitude, current.longitude);
    directions = await LocationService().getDirections(
        origin: LatLng(current.latitude, current.longitude), destination: pos);
    Get.back();
    update();
  }
}
