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

  static CourseModel fromJson(e) {
    return CourseModel(
        id: 1,
        rank: e['numberOfStudents'].toString(),
        courseTitle: e['name'],
        duration: '15',
        price: e['price'].toString(),
        isBookmarked: true,
        image: 'assets/images/course1.png',
        description: e['description']);
  }
}
