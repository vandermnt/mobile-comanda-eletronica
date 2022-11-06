import 'dart:convert';

class Product {
  int id;
  String name;
  String price;
  String description;

  Product(this.id, this.name, this.price, this.description);

  static Product fromMap(Map<String, dynamic> map) {
    return Product(map["id"], map['name'], map['price'], map['description']);
  }

  static String toJson(Product product) {
    return jsonEncode(toObject(product));
  }

  static toObject(Product product) {
    return {
      "id": product.id,
      "name": product.name,
      "price": product.price,
      "description": product.description,
    };
  }

  static List<Product> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  static List<Product> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Product>((map) => Product.fromMap(map)).toList();
  }
}
