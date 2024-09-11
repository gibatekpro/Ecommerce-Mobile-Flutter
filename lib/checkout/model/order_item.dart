import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  String imageUrl;

  int quantity;

  double unitPrice;

  int productId;

  OrderItem(
      {required this.imageUrl,
      required this.unitPrice,
      required this.quantity,
      required this.productId});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  String toString() {
    return 'OrderItem{imageUrl: $imageUrl, quantity: $quantity, unitPrice: $unitPrice, productId: $productId}';
  }
}
