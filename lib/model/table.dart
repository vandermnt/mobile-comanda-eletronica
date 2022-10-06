import 'dart:convert';

class Tables {
  int? id;
  bool? status;
  int? number;

  Tables(this.id, this.status, this.number);

  static Tables fromMap(Map<String, dynamic> map) {
    return Tables(
      map["id"],
      map['status'],
      map['number'],
    );
  }

  static String toJson(Tables table) {
    return jsonEncode(toObject(table));
  }

  static toObject(Tables table) {
    return {
      "id": table.id,
      "status": table.status,
      "number": table.number,
    };
  }

  static List<Tables> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Tables.fromMap(maps[i]);
    });
  }

  static List<Tables> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Tables>((map) => Tables.fromMap(map)).toList();
  }
}
