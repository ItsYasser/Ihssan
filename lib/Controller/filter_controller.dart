import 'package:flutter_festival/Models/filter_model.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  late FilterModel filter;
  @override
  FilterController(String fil) {
    // TODO: implement onInit
    filter = FilterModel(helpType: fil, services: []);
    super.onInit();
  }
}
