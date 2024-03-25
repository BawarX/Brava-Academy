import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _imageUrl = '';
  String _password = '';
  String _email = '';

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get password => _password;
  String get imageUrl => _imageUrl;
  String get email => _email;

  void setUser({required String firstName, required String lastName, required String imageUrl, required String email, required String password}) {
    _firstName = firstName;
    _lastName = lastName;
    _imageUrl = imageUrl;
    _email = email;
    _password = password;

    notifyListeners();
  }
}
