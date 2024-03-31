class CourseModel {
  String id;
  int rank;
  String courseTitle;
  String duration;
  String price;
  String image;
  String description;
  String authorId;
  List videos;
  String authorName;
  String authorImage;
  bool isBookmarked;
  List students;

  CourseModel({
    required this.authorId,
    required this.authorName,
    required this.videos,
    required this.id,
    required this.rank,
    required this.courseTitle,
    required this.duration,
    required this.price,
    required this.isBookmarked,
    required this.authorImage,
    required this.image,
    required this.description,
    required this.students,
  });

  static CourseModel fromJson(e) {
    return CourseModel(
        id: e['_id'],
        videos: e['videos'],
        rank: e['numberOfStudents'],
        courseTitle: e['name'],
        duration: '15',
        authorId: e['author']['_id'],
        authorName: "${e['author']['firstname']} ${e['author']['lastname']}",
        authorImage: e['author']['image'],
        students: e['Students'],
        price: e['price'].toString(),
        isBookmarked: false,
        image: e['backgroundImage'],
        description: e['description']);
  }
}
