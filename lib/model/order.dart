import 'dart:convert';

class Order {
  int id;
  int qtdeProduct;
  String note;
  int tableId;
  int productId;

  Order(this.id, this.qtdeProduct, this.note, this.tableId, this.productId);

  static Order fromMap(Map<String, dynamic> map) {
    return Order(map["id"], map['qtdeProduct'], map['note'], map['tableId'],
        map['productId']);
  }

  static String toJson(Order order) {
    return jsonEncode(toObject(order));
  }

  static toObject(Order order) {
    return {
      "id": order.id,
      "qtdeProduct": order.qtdeProduct,
      "note": order.note,
      "tableId": order.tableId,
      "productId": order.productId
    };
  }
}
