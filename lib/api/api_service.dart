import 'dart:convert';
import 'dart:developer';

import 'package:brava/screen/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var url = Uri.parse('http://10.0.2.2:3000/user/get-user-by-email/$email');
      final response = await http.get(
        url,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['data']['password']);
        if (password == data['data']['password']) {
          log('Loging ============================>');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          log('Wrong Password');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  void signUp(
      String firstname, String lastname, String email, String password) async {
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
