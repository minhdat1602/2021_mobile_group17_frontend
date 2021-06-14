import 'package:mobile_nhom17_2021/models/brand.dart';
import 'package:mobile_nhom17_2021/models/category.dart';
import 'package:mobile_nhom17_2021/models/collection.dart';

class Data {
  static List<Brand> brands = [
    new Brand(id: 1, name: "Adidas", collections: collections1),
    new Brand(id: 2, name: "Nike", collections: collections2),
    new Brand(id: 3, name: "New Balance", collections: collections3),
    new Brand(id: 4, name: "Rebook", collections: collections4),
  ];

  static List<Category> categories = [
    new Category(id: 1, name: "Football"),
    new Category(id: 2, name: "LifeStyle"),
    new Category(id: 3, name: "Tenis"),
    new Category(id: 4, name: "Running"),
  ];

  static List<Collection> collections1 = [
    new Collection(id: 1, name: "AMD"),
    new Collection(id: 2, name: "Super Star"),
    new Collection(id: 3, name: "Ultra boost"),
  ];

  static List<Collection> collections2 = [
    new Collection(id: 1, name: "Air Force"),
    new Collection(id: 2, name: "Air Jordan"),
  ];

  static List<Collection> collections3 = [
    new Collection(id: 1, name: "Air Force"),
    new Collection(id: 2, name: "Air Jordan"),
  ];

  static List<Collection> collections4 = [
    new Collection(id: 1, name: "Air Force"),
    new Collection(id: 2, name: "Air Jordan"),
  ];
}
