class Reservation {
  final int id;
  final String day;
  final String year;
  final String lecture;
  final String doctor;
  final String place;
  final String from;
  final String to;
  final String createdAt;
  final String updatedAt;

  Reservation({
    required this.id,
    required this.day,
    required this.year,
    required this.lecture,
    required this.doctor,
    required this.place,
    required this.from,
    required this.to,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      day: json['day'],
      year: json['year'],
      lecture: json['lecture'],
      doctor: json['doctor'],
      place: json['place'],
      from: json['from'],
      to: json['to'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'year': year,
      'lecture': lecture,
      'doctor': doctor,
      'place': place,
      'from': from,
      'to': to,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
