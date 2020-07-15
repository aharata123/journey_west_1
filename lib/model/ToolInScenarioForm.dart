
class ToolInScenarioForm {
  int idScenario, idTool, quantity;


  ToolInScenarioForm({
    this.idScenario,
    this.idTool,
    this.quantity,
  });

  Map toJson() => {
    "IdScenario": idScenario,
    "IdTool": idTool,
    "quantity": quantity,
  };


  factory ToolInScenarioForm.fromJson(Map<String, dynamic> json) {
    return ToolInScenarioForm(
      idScenario: json['IdScenario'],
      idTool: json['IdTool'],
      quantity: json['Quantity'],
    );
  }

  Map<String, dynamic> toMap() =>
      {
        "IdScenario": idScenario,
        "IdTool": idTool,
        "Quantity": quantity,
      };

}