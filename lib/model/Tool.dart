class Tool {
  String name, description, image;
  int quantity, id;
  DateTime dateCreated;

  Tool({
    this.id,
    this.name,
    this.description,
    this.image,
    this.quantity,
    this.dateCreated,
  });

  factory Tool.fromJson(Map<String, dynamic> json) {
    return Tool(
        id: json['IdTool'],
        name: json['Name'],
        description: json['Description'],
        image: json['Image'],
        dateCreated: DateTime.parse(json['DateCreated']),
        quantity: json['Quantity']
    );
  }

  Map<String, String> toMap() =>
      {
        "Name": name,
        "Description": description,
        "Image": image,
        "Quantity": quantity.toString(),
      };

}