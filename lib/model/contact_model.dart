class Contact {
  int? id;
  String? name;
  String? mobileNumber;
  String? email;
  String? company;

  Contact({this.id, this.name, this.mobileNumber, this.email, this.company});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['mobileNumber'] = mobileNumber;
    map['email'] = email;
    map['company'] = company;

    return map;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.mobileNumber = map['mobileNumber'];
    this.email = map['email'];
    this.company = map['company'];
  }
}
