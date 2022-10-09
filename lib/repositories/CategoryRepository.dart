import 'package:mobile_comanda_eletronica/rest/category_rest.dart';

class CategoryRepository {
  final CategoryRest api = CategoryRest();

  Future getAll() async {
    return await api.getAll();
  }
}
