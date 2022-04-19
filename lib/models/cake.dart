// ignore_for_file: non_constant_identifier_names

class Cake {
  final int? cake_id;
  final String cake_name;
  final int cake_category;
  final String cake_image;

  Cake({
    this.cake_id,
    required this.cake_name,
    required this.cake_category,
    required this.cake_image,
  });

  factory Cake.fromMap(Map<String, dynamic> json) => Cake(
        cake_id: json['cake_id'],
        cake_name: json['cake_name'],
        cake_category: json['cake_category'],
        cake_image: json['cake_image'],
      );

  Map<String, dynamic> toMap() => {
        'cake_id': cake_id,
        'cake_name': cake_name,
        'cake_category': cake_category,
        'cake_image': cake_image,
      };
}
