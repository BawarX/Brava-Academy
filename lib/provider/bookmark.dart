import 'package:brava/model/courses.dart';
import 'package:flutter/cupertino.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<Course> _cards = [];
  List<Course> get cards => _cards;

  void addItem(Course courseCart) {
    _cards.add(courseCart);
    notifyListeners();
  }

  void removeItem(Course courseCart) {
    _cards.remove(courseCart);
    notifyListeners();
  }

  bool isBookmarked(Course courseCart) {
    return _cards.contains(courseCart);
  }
}
