class CourseModel {
  int id;
  String rank;
  String courseTitle;
  String duration;
  String price;
  String image;
  String description;
  bool isBookmarked;

  CourseModel({
    required this.id,
    required this.rank,
    required this.courseTitle,
    required this.duration,
    required this.price,
    required this.isBookmarked,
    required this.image,
    required this.description,
  });
}
