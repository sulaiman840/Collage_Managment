class Complaint {
  final int id;
  final int doctorId;
  final String doctorName;
  final String place;
  final String description;
  final String state;
  final String createdAt;
  final String updatedAt;

  Complaint({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.place,
    required this.description,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      doctorId: json['doctor_id'],
      doctorName: json['doctor_name'],
      place: json['place'],
      description: json['descreption'],
      state: json['state'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'place': place,
      'description': description,
      'state': state,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
