// ignore_for_file: non_constant_identifier_names

class Category {
  final int? category_id;
  final String category_name;
  final String category_image;

  Category({
    this.category_id,
    required this.category_name,
    required this.category_image,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    category_id: json['category_id'],
    category_name: json['category_name'],
    category_image: json['category_image'],
  );

  Map<String, dynamic> toMap() => {
    'category_id': category_id,
    'category_name': category_name,
    'category_image': category_image,
  };
}
