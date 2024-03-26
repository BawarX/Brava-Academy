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
  bool isBookmarked;

  CourseModel({
    required this.authorId,
    required this.videos,
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
        id: e['_id'],
        videos: e['videos'] ,
        rank: e['numberOfStudents'],
        courseTitle: e['name'],
        duration: '15',
        authorId: e['author']['_id'],
        price: e['price'].toString(),
        isBookmarked: true,
        image: e['backgroundImage'],
        description: e['description']);
  }
}
