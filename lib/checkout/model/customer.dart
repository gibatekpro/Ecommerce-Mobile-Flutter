import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {

  String firstName;

  String lastName;

  String email;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.email});

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  String toString() {
    return 'Customer{firstName: $firstName, lastName: $lastName, email: $email}';
  }
}