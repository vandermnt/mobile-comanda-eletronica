import 'package:flutter/material.dart';
import 'package:mobile_comanda_eletronica/model/product.dart';

class AddOrder extends StatefulWidget {
  final Product product;

  AddOrder({Key? key, required this.product}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.product.name}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Quantidade',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Observação',
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () => print("dwadiaj"),
                    child: Text("ADICIONAR AO PEDIDO"),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () => print("dwadiaj"),
                    child: Text("CONTINUAR PEDINDO"),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
