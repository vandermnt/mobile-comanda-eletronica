import 'package:flutter/material.dart';
import 'package:mobile_comanda_eletronica/model/product.dart';
import 'package:mobile_comanda_eletronica/repositories/OrderRepository.dart';

class AddOrder extends StatefulWidget {
  final int tableId;
  final int categoryId;
  final Product product;

  AddOrder(
      {Key? key,
      required this.product,
      required this.categoryId,
      required this.tableId})
      : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final orderRepository = OrderRepository();
  final noteController = TextEditingController();
  final qtdController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    qtdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.product.name}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextFormField(
            controller: noteController,
            decoration: const InputDecoration(labelText: "Observação"),
          ),
          TextFormField(
            controller: qtdController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Quantidade"),
          ),
          Container(margin: const EdgeInsets.only(top: 30.0)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,

                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () => this.addOrder(),
              child: const Text("ADICIONAR ITEM")),
          Container(margin: const EdgeInsets.only(top: 10.0)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () => {print("ADICIONAR ITEM")},
              child: const Text("CONTINUAR ADICONANDO"))
        ]),
      ),
    );
  }

  Future addOrder() async {
    final order = buildOrder();
    await orderRepository.addItem(order);
  }

  buildOrder() {
    return {
      "tableId": widget.tableId,
      "productId": widget.product.id,
      "note": noteController.text,
      "qtd": qtdController.text
    };
  }
}
