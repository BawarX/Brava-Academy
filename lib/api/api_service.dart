import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:brava/model/courses.dart';
import 'package:brava/provider/user.dart';
import 'package:brava/screen/Home/home_page.dart';
import 'package:brava/screen/Home/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  void login({required String email, required String password, required BuildContext context}) async {
    try {
      var url = Uri.parse('http://10.0.2.2:3000/user/get-user-by-email/$email');
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        String id = data['data']['_id'];
        String firstname = data['data']['firstname'];
        String lastName = data['data']['lastname'];
        String imageUrl = data['data']['image'];
        String password = data['data']['password'];
        String email = data['data']['email'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('_id', id);
        prefs.setString('firstname', firstname);
        prefs.setString('lastname', lastName);
        prefs.setString('email', email);
        prefs.setString('imageUrl', imageUrl);

        if (password == data['data']['password']) {
          log('Loging ============================>');
          context.read<UserProvider>().setUser(firstName: firstname, imageUrl: imageUrl, email: email, lastName: lastName);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBar(),
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

  void signUp({required String firstname, required String lastname, required String email, required String password, required BuildContext context}) async {
    var url = Uri.parse('http://10.0.2.2:3000/user/add-user');

    final Map<String, dynamic> requestBody = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      print("user added successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const NavBar()));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Course>> getCourse() async {
    const url = 'http://10.0.2.2:3000/course/home';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<Course>((dynamic item) => Course.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<bool> addCourse(String title, String description, List<String> videoUrl, int price, int numOfStudent, String author, String imageUrl, BuildContext context) async {
    var url = Uri.parse('http://10.0.2.2:3000/course/add-course');

    final Map<String, dynamic> requestBody = {
      'name': title,
      'backgroundImage': imageUrl,
      'author': author.toString(),
      'price': price,
      'numberOfStudents': numOfStudent,
      'description': description,
      'videos': videoUrl,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      print("user added successfully");
      return true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const NavBar()));
    } else {
      return false;
      throw Exception('Failed to load data');
    }
  }
}
