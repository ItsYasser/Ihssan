import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:flutter_festival/Controller/data_controller.dart';
import 'package:flutter_festival/Models/person_model.dart';

import 'package:flutter_festival/View/contributor_details.dart';
import 'package:flutter_festival/View/filter_screen.dart';
import 'package:flutter_festival/View/org_details.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../Controller/filter_controller.dart';

class FloatingSearch extends StatefulWidget {
  const FloatingSearch({Key? key, required this.onSelected}) : super(key: key);

  @override
  State<FloatingSearch> createState() => _FloatingSearchState();
  final Function(LatLng) onSelected;
}

class _FloatingSearchState extends State<FloatingSearch> {
  bool isPortrait = false;
  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find<DataController>();
    return GetBuilder<FilterController>(builder: (filterController) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Opacity(
          opacity: .85,
          child: FloatingSearchBar(
            hint: filterController.filter.isPerson()
                ? 'ابحث عن اسم متبرع'
                : 'جمعية ناس الخير',

            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 800),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            axisAlignment: isPortrait ? 0.0 : -1.0,
            openAxisAlignment: 0.0,
            width: isPortrait ? 600 : 500,
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
            debounceDelay: const Duration(milliseconds: 500),

            automaticallyImplyBackButton: false,
            // Specify a custom transition to be used for
            // animating between opened and closed stated.
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: FloatingSearchBarAction.icon(
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
                          padding: const EdgeInsets.all(8.0),
                          child: FilterScreen(),
                        );
                      },
                      anchors: [0, 0.5, 1],
                    );
                  },
                  icon: Icons.filter_alt_outlined,
                ),
              ),
            ],
            controller: floatingSearchBarController,
            leadingActions: [
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            onQueryChanged: (query) {
              // Call your model, bloc, controller here.

              dataController.updateList(
                  query, filterController.filter.isPerson());
            },
            onSubmitted: (val) {},
            onKeyEvent: (v) {},

            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  elevation: 4.0,
                  child: GetBuilder<DataController>(builder: (controller) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: controller
                          .getList(filterController.filter.isPerson())
                          .map((e) {
                        return GestureDetector(
                          onTap: () {
                            floatingSearchBarController.close();
                            widget.onSelected(LatLng(
                                e.locationO!.latitude, e.locationO!.longitude));

                            showFlexibleBottomSheet(
                              minHeight: 0,
                              initHeight: 0.5,
                              maxHeight: 0.5,
                              isExpand: true,
                              isModal: true,
                              context: context,
                              isCollapsible: true,
                              builder: (
                                BuildContext context,
                                ScrollController scrollController,
                                double bottomSheetOffset,
                              ) {
                                return SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        child: e is Person
                                            ? ContributorDetails(
                                                person: e,
                                              )
                                            : OrganisationDetails(e)),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            width: double.infinity,
                            child: Text(e.name!),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
