// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_festival/Controller/add_contributor_controller.dart';
import 'package:flutter_festival/Controller/add_organisation.dart';

import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Util/location.dart';
import 'package:flutter_festival/View/add_contributor.dart';
import 'package:flutter_festival/Widgets/button_widget.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Util/functions.dart';

class PickFromMap extends StatefulWidget {
  final bool organisation;

  const PickFromMap({Key? key, this.organisation = true}) : super(key: key);
  @override
  State<PickFromMap> createState() => PickFromMapState();
}

class PickFromMapState extends State<PickFromMap> {
  final Completer<GoogleMapController> _controller = Completer();
  late Uint8List byteData;
  late GeoPoint position;
  void getMarker() async {
    if (widget.organisation) {
      byteData = await getBytesFromAsset(kOrgMarker, 100);
      return;
    }
    byteData = await getBytesFromAsset(kContMarker, 130);
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

  Marker? markerPosition = null;
  void addMarker(LatLng pos) {
    setState(() {
      markerPosition = Marker(
          markerId: const MarkerId(
            'id',
          ),
          infoWindow: const InfoWindow(
            title: 'موقعك',
          ),
          icon: BitmapDescriptor.fromBytes(byteData),
          position: pos);
    });
    position = GeoPoint(pos.latitude, pos.longitude);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return new Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "تحديد الموقع",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white.withOpacity(.9),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back(result: false);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: kPrimaryColor,
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
              child: Button(
            onTap: () {
              setState(() {
                markerPosition = null;
                position = GeoPoint(0, 0);
              });
            },
            text: "حذف",
            backGroundColor: Colors.white,
            textColor: Colors.black,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          )),
          Expanded(
              child: Button(
            onTap: () {
              if (markerPosition == null) {
                snackBar(
                    title: "خطأ في التأكيد",
                    message: "الرجاء تحديد موقع من الخريطة");
                return;
              }
              if (!widget.organisation) {
                AddContributorController controller =
                    Get.find<AddContributorController>();
                controller.location = position;
              } else {
                AddOrganisationController controller =
                    Get.find<AddOrganisationController>();
                controller.location = position;
              }

              Get.back(result: true);
            },
            text: "تأكيد",
            backGroundColor: kPrimaryColor,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          )),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              buildingsEnabled: false,
              onTap: (pos) {
                addMarker(pos);
              },
              markers: {
                if (markerPosition != null) markerPosition!,
              },
              initialCameraPosition: _initialPos,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
        heroTag: "tag",
        backgroundColor: Colors.white,
        child: Icon(
          Icons.my_location,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
