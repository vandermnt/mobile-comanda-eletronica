import 'package:mobile_comanda_eletronica/rest/order_rest.dart';

class OrderRepository {
  final OrderRest api = OrderRest();

  Future addItem(order) async {
    return await api.addItem(order);
  }
}
