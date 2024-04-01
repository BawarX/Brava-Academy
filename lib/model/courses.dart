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
  List students;
  bool isBookmarked;

  CourseModel({
    required this.isBookmarked,
    required this.authorId,
    required this.authorName,
    required this.videos,
    required this.id,
    required this.rank,
    required this.courseTitle,
    required this.duration,
    required this.price,
    required this.authorImage,
    required this.image,
    required this.description,
    required this.students,
  });

  static CourseModel fromJson(e) {
    print(e['numberOfStudents']);
    print(e['Students']);
    print(e['price']);
    print(e['videos']);
    print(e['author']['_id']);
    print(e['_id']);
    print(e['author']['firstname']);
    print(e['author']['lastname']);
    print(e['author']['image']);
    print(e['backgroundImage']);
    print(e['description']);
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
        image: e['backgroundImage'],
        isBookmarked: false,
        description: e['description']);
  }

  Map<String, dynamic> tojson() {
    return {
      'courseTitle': courseTitle,
      'description': description,
      'price': price,
      'duration': duration,
      'image': image,
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'authorImage': authorImage,
      'videos': videos,
      'rank': rank,
      'students': students,
      'isBookmarked': isBookmarked,
    };
  }

  static CourseModel fromJsonforsharedpref(data) {
    return CourseModel(
      authorId: data['authorId'],
      authorName: data['authorName'],
      videos: data['videos'],
      id: data['id'],
      rank: data['rank'],
      courseTitle: data['courseTitle'],
      duration: data['duration'],
      price: data['price'],
      authorImage: data['authorImage'],
      image: data['image'],
      description: data['description'],
      students: data['students'],
      isBookmarked: data['isBookmarked'],
    );
  }
}
