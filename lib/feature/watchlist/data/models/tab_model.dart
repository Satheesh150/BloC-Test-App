class TabName {
  String? name;

  TabName({this.name});

  TabName.fromJson(Map<String, dynamic> data) {
    name = data["name"];
  }
}
