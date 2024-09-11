import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {

  int totalQuantity;

  double totalPrice;

  Order({
    required this.totalQuantity,
    required this.totalPrice
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return 'Order{totalQuantity: $totalQuantity, totalPrice: $totalPrice}';
  }
}