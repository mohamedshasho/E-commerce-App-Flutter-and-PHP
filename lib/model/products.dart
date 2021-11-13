class Products {
  String id;
  String name;
  String price;
  String description;
  String image;
  String categoryId;
  bool favorite;

  Products(this.id, this.name, this.price, this.description, this.image,
      this.categoryId,
      {this.favorite = false});

  factory Products.fromJson(Map<String, dynamic> data) {
    return Products(data["id"], data["name"], data['price'],
        data["description"], data["picture"], data["category_id"]);
  }
}
