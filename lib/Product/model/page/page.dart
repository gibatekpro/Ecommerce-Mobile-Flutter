import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

@JsonSerializable()
class Page {
  int size;
  int totalElements;
  int totalPages;
  int number;

  Page(
      {required this.size,
      required this.totalElements,
      required this.totalPages,
      required this.number});

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);

  Map<String, dynamic> toJson() => _$PageToJson(this);
}
