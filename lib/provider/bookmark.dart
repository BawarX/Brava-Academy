import 'dart:convert';

import 'package:brava/constant.dart';
import 'package:brava/model/courses.dart';
import 'package:flutter/cupertino.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<CourseModel> _cards = [];
  List<CourseModel> get cards => _cards;

  void addItem(CourseModel courseCart) {
    _cards.add(courseCart);
    notifyListeners();
    List<String> cardsListString = cards
        .map(
          (element) => jsonEncode(element.tojson()),
        )
        .toList();
    sharedPreferences.setStringList('bookmark', cardsListString);
  }

  void removeItem(CourseModel courseCart) {
    _cards.remove(courseCart);
    notifyListeners();
      List<String> cardsListString = cards
        .map(
          (element) => jsonEncode(element.tojson()),
        )
        .toList();
    sharedPreferences.setStringList('bookmark', cardsListString);
  }
  
}
