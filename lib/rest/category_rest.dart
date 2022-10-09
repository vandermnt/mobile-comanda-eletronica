import 'package:http/http.dart' as http;
import 'package:mobile_comanda_eletronica/model/category.dart';

class CategoryRest {
  Future getAll() async {
    var url = Uri.parse('http://192.168.0.79:3333/categories');
    http.Response? response;

    try {
      response = await http.get(url);
      return Category.fromJsonList(response.body);
    } catch (error) {
      throw error;
    }
  }
}
