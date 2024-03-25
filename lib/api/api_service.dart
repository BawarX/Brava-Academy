// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:brava/constant.dart';
import 'package:brava/data/course_data.dart';
import 'package:brava/data/instructor_data.dart';
import 'package:brava/model/courses.dart';
import 'package:brava/model/instructor_model.dart';
import 'package:brava/screen/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class ApiService {
  void login({required String email, required String password, required BuildContext context}) async {
    if (!await isEmailAndPasswordValid(email, password, context)) {
      return;
    }
    print('login======================>');
    try {
      var url = Uri.parse('http://10.0.2.2:3000/user/get-user-by-email/$email');
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var data = body['data'];
        var status = body['status'];
        if (!status) {
          await showQuickAlert(title: 'Something  Wrong!', text: 'Your  Email is  Incorrect', type: QuickAlertType.error, context: context);
        } else {
          if (password == data['password']) {
            await showQuickAlert(title: 'Success!', text: 'Login Successfully', type: QuickAlertType.success, context: context);
            sharedPreferences.setString('user', jsonEncode(data));
            await fetchData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false,
            );
            print('hi');
          } else {
            await showQuickAlert(title: 'Something  Wrong!', text: 'Email OR Password is Incorrect', type: QuickAlertType.error, context: context);
          }
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  void signUp(String firstname, String lastname, String email, String password, BuildContext context) async {
    Map<String, String> data = {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
    };
    if (!await isEmailAndPasswordValid(email, password, context)) {
      return;
    }
    try {
      var url = Uri.parse('http://10.0.2.2:3000/user/add-user');
      final response = await http.post(
        url,
        body: {"data": jsonEncode(data)},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status']) {
          await showQuickAlert(title: 'success', text: 'successfully Create The Account', type: QuickAlertType.success, context: context);
          sharedPreferences.setString('user', jsonEncode(data['data']));
          await fetchData();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
        } else {
          showQuickAlert(title: 'Error', text: data['data'], type: QuickAlertType.error, context: context);
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (ex) {
      print(ex);
    }
  }

  static fetchData() async {
    var url = Uri.parse('http://10.0.2.2:3000/course/home');
    final response = await http.get(url);
    var body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      List<CourseModel> course = [];
      List<Instructor> instructordata = [];
      await body.forEach((element) {
        course.add(CourseModel.fromJson(element));
        // instructordata.add(
        //     Instructor.fromJson(element['author'] as Map<String, dynamic>));
      });
      courseData = course;
      instructorData = instructordata;
    } else {
      return [];
    }
    return;
  }

  static Future<List> fetchusercourses() async {
    var response = await http.get(
      Uri.parse(
          'http://10.0.2.2:3000/course/search-course-by-authorid/65da36fdb2e101cd2b9c3810'),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      return body as List;
    } else {
      print('have erroooooooorrrrrrrrrrrrrrrrrrrrr=====================');
    }
    return [];
  }

  static addCourse(Map<String, dynamic> courseData) async {
<<<<<<< HEAD
    var res = await http
        .post(Uri.parse('http://10.0.2.2:3000/course/add-course'), body: {
=======
    var res = await http.post(Uri.parse('http://192.168.1.5:3000/course/add-course'), body: {
>>>>>>> de476677e93e05f6f1e3402c6b1bf0a3c9e5fe9f
      'data': jsonEncode(courseData),
    });
    var body = jsonDecode(res.body);
    print(body);
  }

  static deleteTheCourse(String courseId) async {
    print(courseId);
    var res = await http.delete(
      Uri.parse('http://10.0.2.2:3000/course/delete-course-by-id/$courseId'),
    );
    var body = jsonDecode(res.body);
    print(body);
  }
}

Future<void> showQuickAlert({required String title, required String text, required QuickAlertType type, required BuildContext context}) async {
  await QuickAlert.show(context: context, type: type, autoCloseDuration: const Duration(seconds: 3), title: title, text: text);
  return;
}

Future<bool> isEmailAndPasswordValid(String email, String password, BuildContext context) async {
  if (!email.contains('@')) {
    await showQuickAlert(title: 'Error', text: 'Invalid email address please enter the Valid Email', type: QuickAlertType.error, context: context);
    return false;
  } else {
    if (password.trim().length < 8) {
      await showQuickAlert(title: 'Error', text: 'Your Password is Invalid ,Password must be at least 8 characters long', type: QuickAlertType.error, context: context);
      return false;
    }
    return true;
  }
}
