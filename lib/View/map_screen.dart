// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_festival/Controller/data_controller.dart';
import 'package:flutter_festival/Models/person_model.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Util/location.dart';

import 'package:flutter_festival/View/contributor_details.dart';

import 'package:flutter_festival/View/org_details.dart';

import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Controller/filter_controller.dart';
import '../Models/organisation_model.dart';
import '../Util/functions.dart';
import '../Widgets/floating_search.dart';
import '../Widgets/multiple_fab.dart';

class MapScreen extends StatefulWidget {
  final String choice;

  const MapScreen({Key? key, required this.choice}) : super(key: key);
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late Uint8List orgImg;
  late Uint8List contImg;
  Future<void> getMarker() async {
    orgImg = await getBytesFromAsset(kOrgMarker, 100);
    contImg = await getBytesFromAsset(kContMarker, 130);
    return;
  }

  @override
  void initState() {
    getMarker();
    super.initState();
  }

  static final CameraPosition _initialPos = CameraPosition(
    target: LatLng(36.2658, 2.7595),
    zoom: 16,
  );
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: getMarker(),
          builder: (context, snap) {
            return GetBuilder<DataController>(
                init: DataController(),
                builder: (dataController) {
                  return GetBuilder<FilterController>(
                    init: FilterController(widget.choice),
                    builder: (controller) => Stack(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("Organisation")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              // ! Organisation part
                              List<Organizer> organisations = [];
                              snapshot.data!.docs.forEach(((element) =>
                                  organisations.add(Organizer.fromJson(
                                      element.data() as Map))));
                              dataController.listOrganizer.clear();
                              dataController.listOrganizer
                                  .addAll(organisations);

                              List<Marker> markers = [];
                              if (!controller.filter.isPerson()) {
                                List.generate(
                                    organisations.length,
                                    (index) => markers.add(
                                          Marker(
                                            visible: controller
                                                    .filter.services!.isEmpty ||
                                                containsAny(
                                                    organisations[index]
                                                        .services,
                                                    controller.filter.services),
                                            markerId: MarkerId(
                                                organisations[index]
                                                        .name
                                                        .toString() +
                                                    Random()
                                                        .nextInt(10000)
                                                        .toString() +
                                                    DateTime.now()
                                                        .millisecond
                                                        .toString()),
                                            infoWindow: InfoWindow(
                                              title: organisations[index].name,
                                            ),
                                            onTap: () {
                                              showFlexibleBottomSheet(
                                                minHeight: 0,
                                                initHeight: 0.5,
                                                maxHeight: 1,
                                                context: context,
                                                builder: (
                                                  BuildContext context,
                                                  ScrollController
                                                      scrollController,
                                                  double bottomSheetOffset,
                                                ) {
                                                  return SafeArea(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Material(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            OrganisationDetails(
                                                                organisations[
                                                                    index]),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                anchors: [0, 0.5, 1],
                                              );
                                            },
                                            icon: BitmapDescriptor.fromBytes(
                                                orgImg),
                                            position: LatLng(
                                                organisations[index]
                                                    .locationO!
                                                    .latitude,
                                                organisations[index]
                                                    .locationO!
                                                    .longitude),
                                          ),
                                        ));
                              }
                              markers.add(
                                Marker(
                                  visible: true,
                                  markerId: MarkerId("myPosition"),
                                  infoWindow: InfoWindow(
                                    title: "موقعي",
                                  ),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueViolet),
                                  position: dataController.currentPosition,
                                ),
                              );
                              // !
                              return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Person")
                                      .snapshots(),
                                  builder: (context, snapshot2) {
                                    if (!snapshot2.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    // ! Person part
                                    List<Person> persons = [];
                                    snapshot2.data!.docs.forEach(((element) =>
                                        persons.add(Person.fromJson(
                                            element.data() as Map))));
                                    dataController.listPerson.clear();
                                    dataController.listPerson.addAll(persons);
                                    if (controller.filter.isPerson()) {
                                      List.generate(
                                          persons.length,
                                          (index) => markers.add(
                                                Marker(
                                                  visible: controller.filter
                                                          .services!.isEmpty ||
                                                      containsAny(
                                                          persons[index].sadaka,
                                                          controller
                                                              .filter.services),
                                                  markerId: MarkerId(
                                                      persons[index]
                                                              .name
                                                              .toString() +
                                                          DateTime.now()
                                                              .millisecond
                                                              .toString()),
                                                  infoWindow: InfoWindow(
                                                    title: persons[index].name,
                                                  ),
                                                  onTap: () {
                                                    showFlexibleBottomSheet(
                                                      minHeight: 0,
                                                      initHeight: 0.5,
                                                      maxHeight: 1,
                                                      context: context,
                                                      builder: (
                                                        BuildContext context,
                                                        ScrollController
                                                            scrollController,
                                                        double
                                                            bottomSheetOffset,
                                                      ) {
                                                        return SafeArea(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Material(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    ContributorDetails(
                                                                  person:
                                                                      persons[
                                                                          index],
                                                                )),
                                                          ),
                                                        );
                                                      },
                                                      anchors: [0, 0.5, 1],
                                                    );
                                                  },
                                                  icon: BitmapDescriptor
                                                      .fromBytes(contImg),
                                                  position: LatLng(
                                                      persons[index]
                                                          .locationO!
                                                          .latitude,
                                                      persons[index]
                                                          .locationO!
                                                          .longitude),
                                                ),
                                              ));
                                    }

                                    // !
                                    return GoogleMap(
                                      mapType: MapType.normal,
                                      zoomControlsEnabled: false,
                                      mapToolbarEnabled: false,
                                      buildingsEnabled: false,
                                      onTap: (lat) {
                                        print(lat);
                                      },
                                      polylines: {
                                        if (dataController.directions != null)
                                          Polyline(
                                            polylineId: const PolylineId(
                                                'overview_polyline'),
                                            color: Colors.red,
                                            width: 5,
                                            points: dataController
                                                .directions!.polylinePoints
                                                .map((e) => LatLng(
                                                    e.latitude, e.longitude))
                                                .toList(),
                                          ),
                                      },
                                      markers: Set<Marker>.of(markers),
                                      initialCameraPosition: _initialPos,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controller.complete(controller);
                                      },
                                    );
                                  });
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.04),
                          child: FloatingSearch(onSelected: (latLng) async {
                            final GoogleMapController controller =
                                await _controller.future;
                            controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                    target: LatLng(
                                        latLng.latitude, latLng.longitude),
                                    zoom: 15),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                });
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MultipleFab(),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              Position current = await determinePosition();
              DataController data = Get.find<DataController>();
              data.currentPosition =
                  LatLng(current.latitude, current.longitude);
              data.update();
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(current.latitude, current.longitude),
                      zoom: 16),
                ),
              );
            },
            heroTag: "hero",
            backgroundColor: Colors.white,
            child: Icon(
              Icons.my_location,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
