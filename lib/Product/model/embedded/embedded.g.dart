// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Embedded _$EmbeddedFromJson(Map<String, dynamic> json) => Embedded(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmbeddedToJson(Embedded instance) => <String, dynamic>{
      'products': instance.products,
    };
