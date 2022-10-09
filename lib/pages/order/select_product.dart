import 'package:flutter/material.dart';
import 'package:mobile_comanda_eletronica/model/product.dart';
import 'package:mobile_comanda_eletronica/repositories/ProductRepository.dart';

class SelectProduct extends StatefulWidget {
  const SelectProduct({Key? key}) : super(key: key);

  @override
  State<SelectProduct> createState() => _SelectProductState();
}

class _SelectProductState extends State<SelectProduct> {
  List<Product> products = [];

  final productRepository = ProductRepository();

  @override
  void initState() {
    super.initState();
    getAllProducts();
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
                  print("meu ovo");
                },
                child: Container(
                  padding: EdgeInsets.all(7.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Card(
                          color: Color.fromARGB(255, 213, 252, 255),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(children: <Widget>[
                                Text(
                                  "${products[index].name} | ${products[index].price}",
                                  // maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "${products[index].description}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }

  Future getAllProducts() async {
    final productsFromRepository = await productRepository.getAll();
    setState(() {
      products = productsFromRepository;
    });
  }

  Future addOrder() async {}
}
