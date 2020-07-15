
class ToolInScenario {
  int idScenario, idTool, quantity;
  String toolName, image;

  ToolInScenario({
    this.idScenario,
    this.idTool,
    this.quantity,
    this.toolName,
    this.image,
  });

  factory ToolInScenario.fromJson(Map<String, dynamic> json) {
    return ToolInScenario(
      idScenario: json['IdScenario'],
      idTool: json['IdTool'],
      quantity: json['Quantity'],
      toolName: json['Name'],
      image: json['Image'],
    );
  }

//  Map<String, dynamic> toMap() =>
//      {
//        "IdScenario": idScenario,
//        "RoleName": roleName,
//        "IdActor": idActor,
//      };

}