import 'dart:convert';

import 'package:brava/model/login_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  void login() async {
    try {
      var url = Uri.parse('http://10.0.2.2:3000/user/get-user-by-id/65da2a12fcac44195a065697');
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("success?");
        print(data);
      } else {
        print(response.statusCode);
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  void signUp(String firstname, String lastname, String email, String password) async {
    // Uri url = "http://10.0.2.2:3000/user/add-user" as Uri;
    var url = Uri.parse('http://10.0.2.2:3000/user/add-user');
    final response = await http.post(url, body: {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      print("user added successfully");
    } else {
      throw Exception('Failed to load data');
    }
  }
}
