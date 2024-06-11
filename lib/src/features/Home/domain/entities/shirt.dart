class Shirt {
  final String name;
  final String imagePath;
  final double price;
  final String? color;
  final String? size;

  Shirt({
    required this.name,
    required this.imagePath,
    required this.price,
    this.color,
    this.size,
  });

  /*
  calculateDiscountedPrice(discount) {
    return this.price * (1 - discount);
  }
  */
}

List<Shirt> listOfShirts() {
  return [
    Shirt(name: "Shirt1", imagePath: "shirt1.png", price: 190.0),
    Shirt(name: "Shirt2", imagePath: "shirt2.png", price: 250.0),
    Shirt(name: "Shirt3", imagePath: "shirt3.png", price: 149.0),
    Shirt(name: "Shirt4", imagePath: "shirt4.png", price: 210.0),
    Shirt(name: "Shirt5", imagePath: "shirt5.png", price: 149.0),
    Shirt(name: "Shirt6", imagePath: "shirt6.png", price: 125.0),
    Shirt(name: "Shirt7", imagePath: "shirt7.png", price: 300.0),
    Shirt(name: "Shirt8", imagePath: "shirt8.png", price: 180.0),
    Shirt(name: "Shirt9", imagePath: "shirt9.png", price: 210.0),
  ];
}