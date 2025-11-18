class ProductModel {
  final String id;
  final String title;
  final String price;
  final String description;
  final String category;
  final String rating;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.rating,
    required this.category,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      price: json['price'].toString(),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      rating: json['rating']['rate'].toString(),
      imageUrl: json['image'] ?? '',
    );
  }
}
