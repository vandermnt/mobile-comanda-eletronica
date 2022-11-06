import 'dart:convert';

class Order {
  int qtdeProduct;
  String note;
  int tableId;
  int productId;
  double value;

  Order(this.qtdeProduct, this.note, this.tableId, this.productId, this.value);

  static Order fromMap(Map<String, dynamic> map) {
    return Order(map['qtdeProduct'], map['note'], map['tableId'],
        map['productId'], map['value']);
  }

  static String toJson(Order order) {
    return jsonEncode(toObject(order));
  }

  static toObject(Order order) {
    return {
      "order": {
        "qtdeProduct": order.qtdeProduct,
        "note": order.note,
        "tableId": order.tableId,
        "productId": order.productId,
        "value": order.value
      }
    };
  }
}
