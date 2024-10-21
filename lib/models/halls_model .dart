
class Hall {
  final int id;
  final String name;
  final String projector;
  final String descreption;
  final String createdAt;
  final String updatedAt;

  Hall({
    required this.id,
    required this.name,
    required this.projector,
    required this.descreption,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Hall.fromJson(Map<String, dynamic> json) {
    return Hall(
      id: json['id'],
      name: json['name'],
      projector: json['projector'],
      descreption: json['descreption'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'projector': projector,
      'descreption': descreption,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class HallsResponse {
  final List<Hall> halls;

  HallsResponse({required this.halls});

  factory HallsResponse.fromJson(Map<String, dynamic> json) {
    var hallsJson = json['halls'] as List;
    List<Hall> hallsList = hallsJson.map((i) => Hall.fromJson(i)).toList();

    return HallsResponse(halls: hallsList);
  }

  Map<String, dynamic> toJson() {
    return {
      'halls': halls.map((hall) => hall.toJson()).toList(),
    };
  }
}
