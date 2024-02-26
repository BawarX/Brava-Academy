import 'package:brava/model/courses.dart';
import 'package:flutter/cupertino.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<CourseModel> _cards = [];
  List<CourseModel> get cards => _cards;

  void addItem(CourseModel courseCart) {
    _cards.add(courseCart);
    notifyListeners();
  }

  void removeItem(CourseModel courseCart) {
    _cards.remove(courseCart);
    notifyListeners();
  }
}
