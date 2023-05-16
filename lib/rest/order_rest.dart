import 'package:http/http.dart' as http;
import '../model/order.dart';
import '../shared/config.dart';

class OrderRest {
  Future addItem(order) async {
    var url = Uri.parse('http://192.168.0.104:3333/orders');
    http.Response? response;

    try {
      response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: Order.toJson(order));

      if (response.statusCode == 201) {
        return ("ok");
      }

      throw Exception("Error create order!");
    } catch (error) {
      throw error;
    }
  }
}
