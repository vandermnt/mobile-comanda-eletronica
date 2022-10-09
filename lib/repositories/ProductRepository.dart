import 'package:mobile_comanda_eletronica/rest/category_rest.dart';
import 'package:mobile_comanda_eletronica/rest/product_rest.dart';

class ProductRepository {
  final ProductRest api = ProductRest();

  Future getAll() async {
    return await api.getAll();
  }
}
