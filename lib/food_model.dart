class Food {
  int id;
  String name;
  String description;
  double price;
  String imageUrl;

  Food({required this.id, required this.name, required this.description, required this.price, required this.imageUrl});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
    );
  }
}