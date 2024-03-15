class Author {
  String? sId;
  String? firstname;
  String? lastname;
  String? image;

  Author({this.sId, this.firstname, this.lastname, this.image});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['image'] = image;
    return data;
  }
}
