import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_comanda_eletronica/model/table.dart';
import 'package:mobile_comanda_eletronica/pages/login/login.dart';
import 'package:mobile_comanda_eletronica/pages/order/select_category.dart';
import 'package:mobile_comanda_eletronica/repositories/TableRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ScrollController _scrollController;

  List<Tables> tables = [];

  final TableRepository tableRepository = TableRepository();

  @override
  void initState() {
    EasyLoading.show(status: '');
    super.initState();

    verifyToken().then((token) {
      EasyLoading.dismiss();
      if (!token) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      } else {
        getAllTables();
      }
    });

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mesas"),
      ),

      body: ListView.builder(
          itemCount: tables.length,
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SelectCategory(tableId: tables[index].id)));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isAvailable(tables[index].status),
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    minimumSize: Size(600, 70),
                    // Text Color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(opacity: 0, child: Icon(Icons.arrow_forward)),
                      Text('${tables[index].number}'),
                    ],
                  ),
                ));
          }),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future getAllTables() async {
    final tablesFromRepository = await tableRepository.getAll();
    setState(() {
      tables = tablesFromRepository;
    });
  }

  isAvailable(status) {
    return status ? Colors.green : Colors.red;
  }

  Future<bool> verifyToken() async {
    // verifica se tem um chave token dentro do aplicativo
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('token') != null) {
      return true;
    }

    return false;
  }
}
