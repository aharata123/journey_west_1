
class RoleInScenario {
  int idScenario, idActor;
  String roleName, nameActor, image;


  RoleInScenario({
    this.idScenario,
    this.idActor,
    this.roleName,
    this.nameActor,
    this.image,
  });

  factory RoleInScenario.fromJson(Map<String, dynamic> json) {
    return RoleInScenario(
        idScenario: json['IdScenario'],
        idActor: json['IdActor'],
        roleName: json['RoleName'],
        nameActor: json['NameActor'],
        image: json['Image'],
    );
  }

//  Map<String, String> toMap() =>
//      {
//        "Name": name,
//        "Description": description,
//        "PhoneNumber": phone.toString(),
//        "Email": email,
//        "Image": image,
//        "username": username,
//        "password": password,
//      };


}