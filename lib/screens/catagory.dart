class Category {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      name: json['strCategory'],
      imageUrl: json['strCategoryThumb'],
      description: json['strCategoryDescription'],
    );
  }
}