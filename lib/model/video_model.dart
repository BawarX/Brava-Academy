import 'package:brava/screen/Home/add_course.dart';
import 'package:flutter/material.dart';

class Video {
  final TextEditingController videoTitle;
  String videoUrl;
  ImageType videoType;
  Video({required this.videoTitle, required this.videoUrl, this.videoType = ImageType.File});
}
