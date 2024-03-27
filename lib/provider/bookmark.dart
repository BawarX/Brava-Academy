import 'package:brava/model/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<CourseModel> _cards = [];
  List<CourseModel> get cards => _cards;

  late SharedPreferences _prefs;

  void addItem(CourseModel courseCart) {
    _cards.add(courseCart);
    _prefs.setBool(courseCart.isBookmarked as String, true);
    notifyListeners();
  }

  void removeItem(CourseModel courseCart) {
    _cards.remove(courseCart);
    notifyListeners();
  }
}
