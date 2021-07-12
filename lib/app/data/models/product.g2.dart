// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson2(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    description: json['description'] as String,
    isHot: json['isHot'] as int,
    isNew: json['isNew'] as int,
    colour: json['colour'] as String,
    discount: (json['discount'] as num)?.toDouble(),
    material: json['material'] as String,
    images: (json['images'] as List)
        ?.map((e) =>
            e == null ? null : ImageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    types: (json['types'] as List)
        ?.map(
            (e) => e == null ? null : Type.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    collection: json['collection'] == null
        ? null
        : Collection.fromJson(json['collection'] as Map<String, dynamic>),
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    inputDetails: (json['inputDetails'] as List)
        ?.map((e) =>
            e == null ? null : InputDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isHighlign: json['isHighlign'] as int,
    originPrice: (json['originPrice'] as num)?.toDouble(),
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductToJson2(Product instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'originPrice': instance.originPrice,
      'price': instance.price,
      'discount': instance.discount,
      'description': instance.description,
      'material': instance.material,
      'colour': instance.colour,
      'isHot': instance.isHot,
      'isNew': instance.isNew,
      'isHighlign': instance.isHighlign,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'types': instance.types?.map((e) => e?.toJson())?.toList(),
      'collection': instance.collection?.toJson(),
      'category': instance.category?.toJson(),
      'inputDetails': instance.inputDetails?.map((e) => e?.toJson())?.toList(),
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
    };
