class Category {
  final String id; 
  final String name;
  final String imageUrl; 
  final String description; 

  // Constructor for creating a Category object
  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  // Factory method to create a Category object from JSON data
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      name: json['strCategory'], 
      imageUrl: json['strCategoryThumb'], // Extracting the image URL from JSON data
      description: json['strCategoryDescription'], 
    );
  }
}
