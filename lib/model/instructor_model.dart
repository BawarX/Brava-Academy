class Instructor {
  int id;
  String image;
  String name;
  String fullname;

  Instructor({required this.id, required this.image, required this.name,required this.fullname});

  static Instructor fromJson(Map<String, dynamic> map) {
    return Instructor(
        id: 4, image: 'assets/images/guy1.png', name: map['firstname'],fullname: "${map['firstname']} ${map['lastname']}");
  }
}
