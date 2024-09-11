import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_info.g.dart';

@JsonSerializable()
class PaymentInfo {
  int amount;
  String currency;
  String description;
  String receiptEmail;

  PaymentInfo(
      {required this.amount,
      required this.currency,
      required this.description,
      required this.receiptEmail});

  factory PaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoToJson(this);

  @override
  String toString() {
    return 'PaymentInfo{amount: $amount, currency: $currency, description: $description, receiptEmail: $receiptEmail}';
  }
}
