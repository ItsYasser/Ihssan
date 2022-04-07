class FilterModel {
  String? helpType;
  List<String>? services;
  FilterModel({this.helpType, this.services});
  bool isPerson() {
    if (helpType == "الجمعيات الخيرية") return false;
    return true;
  }
}
