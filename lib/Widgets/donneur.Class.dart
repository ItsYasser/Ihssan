class Person {
  final String? name;
  final String? adr;
  final String? phone;
  final List<String?>? sadaka;
  final String? info;

  Person({this.name, this.adr, this.phone, this.sadaka, this.info});
  toJason() {
    return {
      "name": name,
      "adr": adr,
      "phone": phone,
      "sadaka": sadaka,
      "info": info
    };
  }
}
