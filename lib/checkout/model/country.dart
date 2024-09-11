
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country{

  int id;

  String code;

  String name;

  Country({required this.id, required this.code, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  String toString() {
    return 'Country{id: $id, code: $code, name: $name}';
  }
}