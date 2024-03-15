import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _username = '';
  String _imageUrl = '';
  String _email = '';

  String get username => _username;
  String get imageUrl => _imageUrl;
  String get email => _email;

  void setUser({required String username, required String imageUrl, required String email}) {
    _username = username;
    _imageUrl = imageUrl;
    _email = email;
    notifyListeners();
  }
}
