import 'dart:convert';

import 'package:brava/model/video_model.dart';

class CourseModel {
  String id;
  int rank;
  String courseTitle;
  String duration;
  String price;
  String image;
  String description;
  List<String> videos;
  String authorId;
  bool isBookmarked;

  CourseModel({required this.authorId, required this.id, required this.rank, required this.courseTitle, required this.duration, required this.price, required this.isBookmarked, required this.image, required this.description, required this.videos});

  static CourseModel fromJson(e) {
    return CourseModel(
      id: e['_id'],
      rank: e['numberOfStudents'],
      courseTitle: e['name'],
      duration: '15',
      authorId: e['author']['_id'],
      price: e['price'].toString(),
      isBookmarked: false,
      image: e['backgroundImage'],
      description: e['description'],
      videos: [e['videos'][0]['video1 url']],
    );
  }
}
