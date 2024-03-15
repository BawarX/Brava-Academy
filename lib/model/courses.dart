import 'dart:convert';

import 'package:brava/model/author.dart';

class Course {
  final String id;
  final String name;
  final String backgroundImage;
  final Author? author;
  final List<String> videos;
  final String description;
  final double price;
  final int numberOfStudents;

  Course({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.author,
    required this.videos,
    required this.description,
    required this.price,
    required this.numberOfStudents,
  });

  static Course fromJson(Map<String, dynamic> json) => Course(
        id: json['_id'],
        name: json['name'],
        backgroundImage: json['backgroundImage'],
        author: json['author'] != null ? Author.fromJson(json['author']) : null,
        videos: List<String>.from(json['videos']),
        description: json['description'],
        price: json['price'].toDouble(),
        numberOfStudents: json['numberOfStudents'],
      );
}
