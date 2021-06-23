import 'package:mobile_nhom17_2021/app/data/models/category.dart';
import 'package:mobile_nhom17_2021/app/data/models/collection.dart';
import 'package:mobile_nhom17_2021/app/data/models/image.dart';
import 'package:mobile_nhom17_2021/app/data/models/input_detail.dart';
import 'package:mobile_nhom17_2021/app/data/models/inventory.dart';
import 'package:mobile_nhom17_2021/app/data/models/review.dart';
import 'package:mobile_nhom17_2021/app/data/models/type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';
part 'product.g2.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  int id;
  String code;
  String name;
  double originPrice;
  double price;
  double discount;
  String description;
  String material;
  String colour;
  int isHot;
  int isNew;
  int isHighlign;

  List<Inventory> inventories;
  List<Image> images;
  List<Type> types;
  Collection collection;
  Category category;
  List<InputDetail> inputDetails;
  List<Review> reviews;

  Product(
      {this.id,
      this.code,
      this.name,
      this.price,
      this.description,
      this.isHot,
      this.isNew,
      this.colour,
      this.discount,
      this.material,
      this.images,
      this.types,
      this.collection,
      this.category,
      this.inputDetails,
      this.inventories,
      this.isHighlign,
      this.originPrice,
      this.reviews});
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  factory Product.fromJson2(Map<String, dynamic> json) =>
      _$ProductFromJson2(json);
  Map<String, dynamic> toJson2() => _$ProductToJson2(this);
  // Map<String, dynamic> toJson() => {
  //       'id': this.id,
  //       'code': this.code,
  //       'name': this.name,
  //       'price': this.price,
  //       'description': this.description,
  //       'hot': this.isHot,
  //       'new': this.isNew,
  //       'colour': this.colour,
  //       'material': this.material,
  //       'type': this.type.toJson(),
  //       'collection': this.collection.toJson(),
  //       'category': this.category.toJson(),
  //       "images": List<dynamic>.from(images.map((e) => e.toJson())),
  //     };

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   Iterable imagesIte = json['images'];
  //   Iterable stocksIte = json['stocks'];
  //   List<Image> _images = imagesIte.map((i) => Image.fromJson(i)).toList();
  //   // List<Stock> _stocks = stocksIte.map((i) => Stock.fromJson(i)).toList();
  //   return Product(
  //     id: json['id'],
  //     code: json['code'],
  //     name: json['name'],
  //     price: json['price'],
  //     description: json['description'],
  //     isHot: json['isHot'],
  //     colour: json['colour'],
  //     material: json['material'],
  //     isNew: json['isNew'],
  //     images: _images,
  //     type: Type.fromJson(json['type']),
  //     collection: Collection.fromJson(json['collection']),
  //     category: Category.fromJson(json['category']),
  //   );
  // }
}
