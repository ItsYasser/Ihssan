// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'dart:async';
import 'dart:typed_data';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_festival/Models/donneur.Class.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Util/location.dart';
import 'package:flutter_festival/View/add_contributor.dart';
import 'package:flutter_festival/View/add_org.dart';
import 'package:flutter_festival/View/contributor_details.dart';
import 'package:flutter_festival/View/filter_screen.dart';
import 'package:flutter_festival/View/org_detals.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Controller/filter_controller.dart';
import '../Models/organisation_model.dart';
import '../Util/functions.dart';

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
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return new Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: getMarker(),
          builder: (context, snap) {
            // if (!snap.hasData) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
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
                        snapshot.data!.docs.forEach(((element) => organisations
                            .add(Organizer.fromJson(element.data() as Map))));
                        List<Marker> markers = [];
                        if (controller.filter.helpType == "الجمعيات الخيرية") {
                          List.generate(
                              organisations.length,
                              (index) => markers.add(
                                    Marker(
                                      visible:
                                          controller.filter.services!.isEmpty ||
                                              containsAny(
                                                  organisations[index].services,
                                                  controller.filter.services),
                                      markerId: MarkerId(
                                          organisations[index].name.toString() +
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
                                            ScrollController scrollController,
                                            double bottomSheetOffset,
                                          ) {
                                            return SafeArea(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Material(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: OrganisationDetails(
                                                      organisations[index]),
                                                ),
                                              ),
                                            );
                                          },
                                          anchors: [0, 0.5, 1],
                                        );
                                      },
                                      icon: BitmapDescriptor.fromBytes(orgImg),
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
                                  persons.add(
                                      Person.fromJson(element.data() as Map))));
                              if (controller.filter.helpType !=
                                  "الجمعيات الخيرية") {
                                List.generate(
                                    persons.length,
                                    (index) => markers.add(
                                          Marker(
                                            visible: controller
                                                    .filter.services!.isEmpty ||
                                                containsAny(
                                                    persons[index].sadaka,
                                                    controller.filter.services),
                                            markerId: MarkerId(
                                                persons[index].name.toString() +
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
                                                              ContributorDetails(
                                                            person:
                                                                persons[index],
                                                          )),
                                                    ),
                                                  );
                                                },
                                                anchors: [0, 0.5, 1],
                                              );
                                            },
                                            icon: BitmapDescriptor.fromBytes(
                                                contImg),
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
                                markers: Set<Marker>.of(markers),
                                initialCameraPosition: _initialPos,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                              );
                            });
                      }),
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        new EdgeInsets.symmetric(vertical: 10),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    fillColor: Colors.white70,
                                    filled: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        showFlexibleBottomSheet(
                                          minHeight: 0,
                                          initHeight: 0.5,
                                          maxHeight: 1,
                                          context: context,
                                          builder: (
                                            BuildContext context,
                                            ScrollController scrollController,
                                            double bottomSheetOffset,
                                          ) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FilterScreen(),
                                            );
                                          },
                                          anchors: [0, 0.5, 1],
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.filter_alt_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    hintText: "جمعية ناس الخير",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Speed(),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              Position current = await determinePosition();
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(current.latitude, current.longitude),
                      zoom: 15),
                ),
              );
            },
            heroTag: "sqdsq",
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

class Speed extends StatelessWidget {
  bool _dialVisible = true;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,

      animatedIconTheme: const IconThemeData(size: 22.0),
      // this is ignored if animatedIcon is non null
      // child: Icon(Icons.add),
      visible: _dialVisible,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: const CircleBorder(),
      children: [
        SpeedDialChild(
            child: SvgPicture.asset(
              "assets/images/charity.svg",
              width: 25,
              height: 25,
            ),
            backgroundColor: Colors.white,
            label: 'اضافة جمعية    ',
            labelStyle:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18.0),
            onTap: () {
              Get.to(() => AddOrg());
            }),
        SpeedDialChild(
            child: SvgPicture.asset(
              "assets/images/contributor.svg",
              width: 25,
              height: 25,
            ),
            backgroundColor: Colors.white,
            label: "تطوع او تبرع",
            labelStyle:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18.0),
            onTap: () {
              Get.to(() => AddContributor());
            }),
      ],
    );
  }
}
