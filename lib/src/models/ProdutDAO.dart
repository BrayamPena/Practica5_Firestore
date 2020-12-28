class ProductDAO {
  String name;
  String model;
  String description;
  String image;

  ProductDAO({this.name, this.model, this.description, this.image});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'model': model,
      'description': description,
      'image': image
    };
  }
}
