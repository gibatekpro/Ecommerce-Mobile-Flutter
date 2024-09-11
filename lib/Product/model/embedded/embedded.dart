import 'package:json_annotation/json_annotation.dart';
import '../../model/product/product.dart';
part 'embedded.g.dart';

@JsonSerializable()
class Embedded{

  List<Product> products;

  Embedded({required this.products});

  factory Embedded.fromJson(Map<String, dynamic> json) =>
      _$EmbeddedFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EmbeddedToJson(this);

}