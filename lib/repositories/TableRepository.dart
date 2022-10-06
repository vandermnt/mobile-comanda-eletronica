import 'package:mobile_comanda_eletronica/rest/table_rest.dart';

class TableRepository {
  final TableRest api = TableRest();

  Future getAll() async {
    return await api.getAll();
  }
}
