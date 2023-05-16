import 'dart:convert';

import 'package:http/http.dart' as http;

class Authenticate {
  Future login(email, password) async {
    final url = Uri.parse('http://192.168.0.104:3333/sessions');
    print(email);
    print(password);

    try {
      final response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode({"email": email, "password": password}));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['token'];
      }
      return null;
    } catch (error) {
      throw error;
    }
  }
}
