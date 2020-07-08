class Scenario {
  String name, description, location, fileURL;
  int timeRecord, id;
  DateTime startDate, endDate;

  Scenario({
    this.id,
    this.name,
    this.description,
    this.location,
    this.timeRecord,
    this.startDate,
    this.endDate,
    this.fileURL,
});

  factory Scenario.fromJson(Map<String, dynamic> json) {
    return Scenario(
      id: json['IdScenario'],
      name: json['ScenarioName'],
      description: json['Description'],
      location: json['Location'],
      startDate: DateTime.parse(json['StartDate']),
      endDate: DateTime.parse(json['EndDate']),
      timeRecord: json['TimeRecord'],
      fileURL: json['FileURL']
    );
  }

  Map<String, String> toMap() =>
      {
        "ScenarioName": name,
        "Description": description,
        "Location": location,
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "TimeRecord": timeRecord.toString(),
        "FileURL": fileURL,
      };

}