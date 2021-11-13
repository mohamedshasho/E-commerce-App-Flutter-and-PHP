class Categories {
  String id;
  String name;

  Categories(this.id, this.name);
  factory Categories.fromJson(Map<String, dynamic> data) {
    return Categories(data["id"], data["name"]);
  }
}
