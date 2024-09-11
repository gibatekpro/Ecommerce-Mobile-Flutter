import 'package:ecommerce_flutter/checkout/model/country.dart';
import 'package:ecommerce_flutter/checkout/model/state.dart';

class Address {
  String city;

  String country;

  String state;

  String street;

  String zipCode;

  Address(
      {required this.city,
      required this.country,
      required this.state,
      required this.street,
      required this.zipCode});

  factory Address.fromJson(Map<String, dynamic> json) {
    //The formControl will return a Country and State instance,
    //So we need to get only their names from the json data
    Country theCountry = json['country'] as Country;
    String countryName = theCountry.name;
    State theState = json['state'] as State;
    String stateName = theState.name;

    return Address(
      city: json['city'] as String,
      country: countryName,
      state: stateName,
      street: json['street'] as String,
      zipCode: json['zipCode'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'city': city,
        'country': country,
        'state': state,
        'street': street,
        'zipCode': zipCode,
      };

  @override
  String toString() {
    return 'Address{city: $city, country: $country, state: $state, street: $street, zipCode: $zipCode}';
  }
}
