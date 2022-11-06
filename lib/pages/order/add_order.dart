import 'package:flutter/material.dart';
import 'package:mobile_comanda_eletronica/model/order.dart';
import 'package:mobile_comanda_eletronica/model/product.dart';
import 'package:mobile_comanda_eletronica/pages/order/select_category.dart';
import 'package:mobile_comanda_eletronica/repositories/OrderRepository.dart';

import '../../main.dart';

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
              onPressed: () {
                showAlertDialog(context);
                this.addOrder();
              },
              child: const Text("ADICIONAR ITEM")),
          Container(margin: const EdgeInsets.only(top: 10.0)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SelectCategory(tableId: widget.tableId)))
                  },
              child: const Text("CONTINUAR ADICIONANDO"))
        ]),
      ),
    );
  }

  Future addOrder() async {
    final order = buildOrder();
    await orderRepository.addItem(order);
    // ignore: use_build_context_synchronously
    await showAlertDialog(context);
  }

  buildOrder() {
    final valueOrder =
        (int.parse(qtdController.text) * double.parse(widget.product.price));
    return Order(int.parse(qtdController.text), noteController.text,
        widget.tableId, widget.product.id, valueOrder.toDouble());
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () => Navigator.of(context).pop(),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Produto adicionado a comanda com sucesso!"),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
