import 'package:flutter/material.dart';
import 'package:mobile_comanda_eletronica/model/category.dart';
import 'package:mobile_comanda_eletronica/pages/order/select_product.dart';
import 'package:mobile_comanda_eletronica/repositories/CategoryRepository.dart';

class SelectCategory extends StatefulWidget {
  final int tableId;

  const SelectCategory({Key? key, required this.tableId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List<Category> categories = [];

  final CategoryRepository categoryRepository = CategoryRepository();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias"),
      ),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectProduct(
                            tableId: widget.tableId,
                            categoryId: categories[index].id)));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,

                    minimumSize: Size(600, 70),
                    // Text Color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(opacity: 0, child: Icon(Icons.arrow_forward)),
                      Text('${categories[index].name.toUpperCase()}'),
                    ],
                  ),
                ));

            // return ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => SelectProduct(
            //             tableId: widget.tableId,
            //             categoryId: categories[index].id)));
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.blueAccent,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Opacity(opacity: 0, child: Icon(Icons.arrow_forward)),
            //       Text('${categories[index].name}'),
            //     ],
            //   ),
            // );
          }),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future getAllCategories() async {
    final categoriesFromRepository = await categoryRepository.getAll();
    setState(() {
      categories = categoriesFromRepository;
    });
  }
}
