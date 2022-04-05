// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/View/add_contributor.dart';
import 'package:flutter_festival/View/add_org.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPos = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return new Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            buildingsEnabled: false,
            markers: {
              Marker(
                markerId: const MarkerId('origin'),
                infoWindow: const InfoWindow(
                  title: 'Pickup',
                ),
                onTap: () {
                  print("details");
                },
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                position: LatLng(37.42796133580664, -122.085749655962),
              ),
            },
            initialCameraPosition: _initialPos,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
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
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "جمعية ناس الخير",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Speed(),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(37.42796133580664, -122.085749655962),
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
