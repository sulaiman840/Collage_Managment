class Lab {
  final int id;
  final String name;
  final int pcNumber;
  final String projector;
  final String descreption;
  final DateTime createdAt;
  final DateTime updatedAt;

  Lab({
    required this.id,
    required this.name,
    required this.pcNumber,
    required this.projector,
    required this.descreption,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      id: json['id'],
      name: json['name'],
      pcNumber: json['pc_number'],
      projector: json['projector'],
      descreption: json['descreption'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class LabsResponse {
  final List<Lab> labs;

  LabsResponse({required this.labs});

  factory LabsResponse.fromJson(Map<String, dynamic> json) {
    return LabsResponse(
      labs: List<Lab>.from(json['labs'].map((x) => Lab.fromJson(x))),
    );
  }
}
