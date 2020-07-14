
class RoleInScenarioForm {
  int idScenario, idActor;
  String roleName;


  RoleInScenarioForm({
    this.idScenario,
    this.idActor,
    this.roleName,
  });

  Map toJson() => {
    "IdScenario": idScenario,
    "RoleName": roleName,
    "IdActor": idActor,
  };


  factory RoleInScenarioForm.fromJson(Map<String, dynamic> json) {
    return RoleInScenarioForm(
      idScenario: json['IdScenario'],
      idActor: json['IdActor'],
      roleName: json['RoleName'],
    );
  }

  Map<String, dynamic> toMap() =>
      {
        "IdScenario": idScenario,
        "RoleName": roleName,
        "IdActor": idActor,
      };

}