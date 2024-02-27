import 'dart:convert';

import 'package:brava/model/login_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  void login(String email) async {
    var url = Uri.parse('http://localhost:3000/user/get-user-by-email');

    final response = await http.post(
      url,
      body: {
        'email': email,
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void signUp(String firstname, String email, String password) async {
    Uri url = "http://localhost:3000/user/add-user" as Uri;
    final response = await http.post(url, body: {
      "firstname": firstname,
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      print("user added successfully");
    } else {
      throw Exception('Failed to load data');
    }
  }
}
