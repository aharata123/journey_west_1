
class Actor {
  int id;
  String name, description, email, image,phone,
  username, password;


  Actor({
    this.id,
    this.name,
    this.description,
    this.email,
    this.image,
    this.username,
    this.phone,
    this.password
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
        password: json['password']
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