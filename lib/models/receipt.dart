// ignore_for_file: non_constant_identifier_names

class Receipt {
  final int? receipt_id;
  final String receipt_ingredients;
  final String receipt_implementation;
  final int receipt_cake;

  Receipt({
    this.receipt_id,
    required this.receipt_ingredients,
    required this.receipt_implementation,
    required this.receipt_cake,
  });

  factory Receipt.fromMap(Map<String, dynamic> json) => Receipt(
        receipt_id: json['receipt_id'],
        receipt_ingredients: json['receipt_ingredients'],
        receipt_implementation: json['receipt_implementation'],
        receipt_cake: json['receipt_cake'],
      );

  Map<String, dynamic> toMap() => {
        'receipt_id': receipt_id,
        'receipt_ingredients': receipt_ingredients,
        'receipt_implementation': receipt_implementation,
        'receipt_cake': receipt_cake,
      };
}
