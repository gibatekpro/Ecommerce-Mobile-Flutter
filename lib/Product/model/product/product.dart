import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int? id;

  final String? sku;

  final String? name;

  final String? description;

  final double unitPrice;

  final String? imageUrl;

  final bool? active;

  final int? unitsInStock;

  final DateTime? dateCreated;

  final DateTime? lastUpdated;

  const Product(
      {required this.id,
      required this.sku,
      required this.name,
      required this.description,
      required this.unitPrice,
      required this.imageUrl,
      required this.active,
      required this.unitsInStock,
      required this.dateCreated,
      required this.lastUpdated
      });

  /*
  * Once you have added the annotations to your code you then need to run the code generator to generate the missing .g.dart generated dart files.

    With a Dart package, run dart run build_runner build in the package directory.

    With a Flutter package, run flutter pub run build_runner build in your package directory.
  * */
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

// return {
// 'id': id,
// 'sku': sku,
// 'name': name,
// 'description': description,
// 'unitPrice': unitPrice,
// 'imageUrl': imageUrl,
// 'active': active,
// 'unitsInStock': unitsInStock,
// };

// return Product(
// id: json['id'],
// sku: json['sku'],
// name: json['name'],
// description: json['description'],
// unitPrice: json['unitPrice'],
// imageUrl: json['imageUrl'],
// active: json['active'],
// unitsInStock: json['unitsInStock'],
// );
