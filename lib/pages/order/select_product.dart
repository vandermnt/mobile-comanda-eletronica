import 'package:flutter/material.dart';
import 'package:mobile_comanda_eletronica/model/product.dart';
import 'package:mobile_comanda_eletronica/pages/order/add_order.dart';
import 'package:mobile_comanda_eletronica/repositories/ProductRepository.dart';

class SelectProduct extends StatefulWidget {
  final int tableId;
  final int categoryId;

  const SelectProduct(
      {Key? key, required this.tableId, required this.categoryId})
      : super(key: key);

  @override
  State<SelectProduct> createState() => _SelectProductState();
}

class _SelectProductState extends State<SelectProduct> {
  List<Product> products = [];

  final productRepository = ProductRepository();

  @override
  void initState() {
    getProductByCategory(widget.categoryId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cardápio"),
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddOrder(
                          product: products[index],
                          categoryId: widget.categoryId,
                          tableId: widget.tableId)));
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        color: Color.fromARGB(255, 24, 167, 220),
                        child: Align(
                          // alignment: Alignment.topLeft,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(20),
                            child: Row(children: <Widget>[
                              SizedBox(
                                width: 200, // set this

                                child: Column(children: <Widget>[
                                  Text("${products[index].name}",
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                  Text(
                                    "${products[index].description}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 234, 234, 234)),
                                  )
                                ]),
                              ),
                              SizedBox(
                                width: 150, // set this
                                child: Column(
                                  children: [
                                    Text("R\$ ${products[index].price}",
                                        style: TextStyle(
                                            backgroundColor: Colors.green,
                                            fontSize: 32,
                                            color: Color.fromARGB(
                                                255, 234, 234, 234)),
                                        textAlign: TextAlign.right),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }

  Future getProductByCategory(categoryId) async {
    final productsFromRepository =
        await productRepository.getProductByCategory(categoryId);
    setState(() {
      products = productsFromRepository;
    });
  }
}
