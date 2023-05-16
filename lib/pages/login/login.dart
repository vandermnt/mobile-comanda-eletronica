import 'package:flutter/material.dart';
import 'package:mobile_comanda_eletronica/rest/authenticate_rest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_loader/easy_loader.dart';

import '../../main.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Authenticate authenticate = Authenticate();

  late final ScrollController _scrollController;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          title: Text('Login'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "E-mail"),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Por favor, digite seu email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Por favor, digite sua senha";
                  }
                  return null;
                },
              ),
              Container(margin: const EdgeInsets.only(top: 30.0)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,

                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    if (_formKey.currentState!.validate()) {
                      final isSucess = await login();
                      if (isSucess) {
                        {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MyApp()));
                        }
                      } else {
                        passwordController.clear();
                        EasyLoading.showError('E-mail ou senha inválida');
                      }
                    } else {
                      EasyLoading.showError('Erro');
                    }
                  },
                  child: const Text("ENTRAR")),
              Container(margin: const EdgeInsets.only(top: 10.0)),
            ]),
          ),
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Future<bool> login() async {
    print(emailController.text);
    print(passwordController.text);

    final token =
        await authenticate.login(emailController.text, passwordController.text);

    if (token != null) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.setString('token', token);
      return true;
    }

    return false;
  }
}
