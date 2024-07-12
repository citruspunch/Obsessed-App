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
      id: json['id'],
      title: json['title'],
      name: json['category'] ?? json['name'],
      imagePath: json['image'] ?? json['imagePath'],
      price: json['price'].toDouble(),
      description: json['description'],
      rating: json['rating'],
      count: json['rating']['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'imagePath': imagePath,
      'price': price,
      'description': description,
      'rating': rating,
      'count': count,
    };
  }

  @override
  bool operator ==(Object other) {
    // Si son exactamente el mismo objeto en memoria
    if (identical(this, other)) return true;

    return other is ClothingItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
