class ClothingItem {
  final String name;
  final String imagePath;
  final double price;
  final String? color;
  final String? size;

  ClothingItem({
    required this.name,
    required this.imagePath,
    required this.price,
    this.color,
    this.size,
  });
}

List<ClothingItem> listOfClothingItems() {
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
}