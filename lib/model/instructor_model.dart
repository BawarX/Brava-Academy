class Instructor {
  int id;
  String image;
  String name;

  Instructor({required this.id, required this.image, required this.name});

  static Instructor fromJson(Map<String, dynamic> map) {
    return Instructor(
        id: 4, image: 'assets/images/guy1.png', name: map['firstname']);
  }
}
