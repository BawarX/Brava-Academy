class Instructor {
  String id;
  String image;
  String name;
  String fullname;

  Instructor(
      {required this.id,
      required this.image,
      required this.name,
      required this.fullname});

  static Instructor fromJson(Map<String, dynamic> map) {
    print(1);
    return Instructor(
        id: map['_id'],
        image: map['image'],
        name: map['firstname'],
        fullname: "${map['firstname']} ${map['lastname']}");
  }
}
