class Reserve {
  final int id;
  final String place;
  final int doctorId;
  final String doctorName;
  final String from;
  final String to;
  final String date;
  final String reason;
  final String state;

  Reserve({
    required this.id,
    required this.place,
    required this.doctorId,
    required this.doctorName,
    required this.from,
    required this.to,
    required this.date,
    required this.reason,
    required this.state,
  });

  factory Reserve.fromJson(Map<String, dynamic> json) {
    return Reserve(
      id: json['id'],
      place: json['place'],
      doctorId: json['doctor_id'],
      doctorName: json['doctor_name'],
      from: json['from'],
      to: json['to'],
      date: json['date'],
      reason: json['reason'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place': place,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'from': from,
      'to': to,
      'date': date,
      'reason': reason,
      'state': state,
    };
  }
}
