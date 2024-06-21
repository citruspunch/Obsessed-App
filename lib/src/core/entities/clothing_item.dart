class ClothingItem {
  final int id;
  final String title;
  final String name;
  final String imagePath;
  final double price;
  final String description;
  final Map<String, dynamic> rating;
  final int count;

  ClothingItem({
    required this.id,
    required this.title,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
    required this.rating,
    required this.count,
  });

  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    // Validar que los datos recibidos sean correctos
    if (json['title'] == null || json['title'] == '') {
      throw Exception('Invalid title');
    }
    if (json['id'] == null || json['id'] <= 0) {
      throw Exception('Invalid id');
    }
    if (json['price'] == null || json['price'] <= 0) {
      throw Exception('Invalid price');
    }
    if (json['description'] == null || json['description'] == '') {
      throw Exception('Invalid description');
    }
    if (json['rating'] == null || json['rating'].length == 0) {
      throw Exception('Invalid rating');
    }

    return ClothingItem(
      title: json['title'],
      id: json['id'],
      name: json['category'],
      imagePath: json['image'],
      price: json['price'].toDouble(),
      description: json['description'],
      rating: json['rating'],
      count: json['rating']['count'],
    );
  }
}

/*List<ClothingItem> listOfClothingItems() {
  return [
    ClothingItem(name: "Item1", imagePath: "shirt1.png", price: 190.0),
    ClothingItem(name: "Item2", imagePath: "shirt2.png", price: 250.0),
    ClothingItem(name: "Item3", imagePath: "shirt3.png", price: 149.0),
    ClothingItem(name: "Item4", imagePath: "shirt4.png", price: 210.0),
    ClothingItem(name: "Item5", imagePath: "shirt5.png", price: 149.0),
    ClothingItem(name: "Item6", imagePath: "shirt6.png", price: 125.0),
    ClothingItem(name: "Item7", imagePath: "shirt7.png", price: 300.0),
    ClothingItem(name: "Item8", imagePath: "shirt8.png", price: 180.0),
    ClothingItem(name: "Item9", imagePath: "shirt9.png", price: 210.0),
  ];
}*/


