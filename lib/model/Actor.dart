
class Actor {
  int id;
  String name, description, email, image,phone,
  username, password, updatedBy;
  DateTime dateUpdated;

  Actor({
    this.id,
    this.name,
    this.description,
    this.email,
    this.image,
    this.username,
    this.phone,
    this.password,
    this.dateUpdated,
    this.updatedBy,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
        id: json['IdActor'],
        name: json['Name'],
        description: json['Description'],
        phone: json['PhoneNumber'],
        email: json['Email'],
        image: json['Image'],
        username: json['username'],
        password: json['password'],
        dateUpdated: DateTime.parse(json['DateUpdated']),
        updatedBy: json['UpdatedBy'],
    );
  }

  Map<String, String> toMap() =>
      {
        "Name": name,
        "Description": description,
        "PhoneNumber": phone.toString(),
        "Email": email,
        "Image": image,
        "username": username,
        "password": password,
      };


}