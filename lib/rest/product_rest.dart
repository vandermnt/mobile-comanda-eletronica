import 'package:http/http.dart' as http;
import 'package:mobile_comanda_eletronica/model/product.dart';

class ProductRest {
  Future getAll() async {
    var url = Uri.parse('http://192.168.0.102:3333/products');
    http.Response? response;

    try {
      response = await http.get(url);
      return Product.fromJsonList(response.body);
    } catch (error) {
      throw error;
    }
  }
}
