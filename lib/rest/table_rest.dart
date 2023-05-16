import 'package:mobile_comanda_eletronica/shared/config.dart';

import 'package:http/http.dart' as http;

import '../model/table.dart';

class TableRest {
  Future getAll() async {
    var url = Uri.parse('http://192.168.0.104:3333/tables');
    http.Response? response;

    try {
      response = await http.get(url);
      return Tables.fromJsonList(response.body);
    } catch (error) {
      throw error;
    }
  }
}
