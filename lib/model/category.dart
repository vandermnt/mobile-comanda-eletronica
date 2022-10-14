import 'dart:convert';

class Category {
  int id;
  String name;

  Category(this.id, this.name);

  static Category fromMap(Map<String, dynamic> map) {
    return Category(map["id"], map['name']);
  }

  static String toJson(Category table) {
    return jsonEncode(toObject(table));
  }

  static toObject(Category category) {
    return {
      "id": category.id,
      "name": category.name,
    };
  }

  static List<Category> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  static List<Category> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Category>((map) => Category.fromMap(map)).toList();
  }
}
