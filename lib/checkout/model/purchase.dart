import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'customer.dart';
import 'order.dart';
import 'order_item.dart';

part 'purchase.g.dart';

@JsonSerializable()
class Purchase {
  Customer customer;

  Address shippingAddress;

  Address billingAddress;

  Order order;

  List<OrderItem> orderItems;

  Purchase(
      {required this.customer,
      required this.shippingAddress,
      required this.billingAddress,
      required this.order,
      required this.orderItems});

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseToJson(this);

  @override
  String toString() {
    return 'Purchase{customer: $customer, '
        'shippingAddress: $shippingAddress, '
        'billingAddress: $billingAddress, '
        'order: $order, orderItems: $orderItems}';
  }
}
