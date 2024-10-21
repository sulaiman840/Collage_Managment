import 'package:dio/dio.dart';
import '../core/utils/config.dart';
import '../models/lab_model.dart';
import '../models/reservation_model.dart';

class LabService {
  final Dio _dio = Dio();

  Future<LabsResponse> fetchLabs() async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/labs',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );
      return LabsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception('Failed to load labs: ${e.response?.statusMessage}');
    }
  }

  Future<Lab> fetchLabDetails(int labId) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/show_lab',
        data: {'lab_id': labId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );
      return Lab.fromJson(response.data['lab']);
    } on DioError catch (e) {
      throw Exception('Failed to load lab details: ${e.response?.statusMessage}');
    }
  }

  Future<void> deleteLab(int labId) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/delete_lab',
        data: {'lab_id': labId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data['message'] != "Lab deleted successfully") {
        throw Exception('Failed to delete lab');
      }
    } on DioError catch (e) {
      throw Exception('Failed to delete lab: ${e.response?.statusMessage}');
    }
  }

  Future<Lab> createLab(String name, int pcNumber, String projector, String descreption) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/add_lab',
        data: {
          'name': name,
          'pc_number': pcNumber,
          'projector': projector,
          'descreption': descreption,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );
      return Lab.fromJson(response.data['lab']);
    } on DioError catch (e) {
      throw Exception('Failed to create lab: ${e.response?.statusMessage}');
    }
  }

  Future<Lab> updateLab(int labId, String name, int pcNumber, String projector, String descreption) async {
    try {
      print('Updating lab with data: lab_id=$labId, name=$name, pc_number=$pcNumber, projector=$projector, descreption=$descreption');
      final response = await _dio.post(
        '${Config.baseUrl}/update_lab',
        data: {
          'lab_id': labId,
          'name': name,
          'pc_number': pcNumber,
          'projector': projector,
          'descreption': descreption,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      return Lab.fromJson(response.data['lab']);
    } on DioError catch (e) {
      print('Failed to update lab: ${e.response?.data}');
      throw Exception('Failed to update lab: ${e.response?.statusMessage}');
    }
  }

  Future<List<Reservation>> fetchReservations(String place) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/formal_place',
        data: {'place': place},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      List<Reservation> reservations = (response.data['formal_place'] as List)
          .map((json) => Reservation.fromJson(json))
          .toList();

      return reservations;
    } on DioError catch (e) {
      throw Exception('Failed to load reservations: ${e.response?.statusMessage}');
    }
  }

  Future<void> deleteReservation(int reservationId) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/delete_formal',
        data: {'formal_id': reservationId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data['message'] != "formal deleted successfully") {
        throw Exception('Failed to delete reservation');
      }
    } on DioError catch (e) {
      throw Exception('Failed to delete reservation: ${e.response?.statusMessage}');
    }
  }

  Future<Reservation> updateReservation(int reservationId, String place, String year, String day, String from, String to, String doctor, String lecture) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/update_formal',
        data: {
          'formal_id': reservationId,
          'place': place,
          'year': year,
          'day': day,
          'from': from,
          'to': to,
          'doctor': doctor,
          'lecture': lecture,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      return Reservation.fromJson(response.data['formal']);
    } on DioError catch (e) {
      throw Exception('Failed to update reservation: ${e.response?.statusMessage}');
    }
  }

  Future<Reservation> addReservation(String place, String year, String day, String from, String to, String doctor, String lecture) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/add_formal',
        data: {
          'place': place,
          'year': year,
          'day': day,
          'from': from,
          'to': to,
          'doctor': doctor,
          'lecture': lecture,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      return Reservation.fromJson(response.data['formal']);
    } on DioError catch (e) {
      throw Exception('Failed to add reservation: ${e.response?.statusMessage}');
    }
  }

  Future<List<String>> fetchDoctors() async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/static_doctors',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      List<String> doctors = (response.data['doctors'] as List)
          .map((doctor) => doctor['name'].toString())
          .toList();

      return doctors;
    } on DioError catch (e) {
      throw Exception('Failed to load doctors: ${e.response?.statusMessage}');
    }
  }

  Future<List<String>> fetchLectures() async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/static_lectures',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      List<String> lectures = (response.data['lectures'] as List)
          .map((lecture) => lecture['name'].toString())
          .toList();

      return lectures;
    } on DioError catch (e) {
      throw Exception('Failed to load lectures: ${e.response?.statusMessage}');
    }
  }
}