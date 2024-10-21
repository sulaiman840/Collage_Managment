import 'package:dio/dio.dart';
import '../core/utils/config.dart';
import '../models/halls_model .dart';
import '../models/reservation_model.dart';

class HallService {
  final Dio _dio = Dio();

  Future<HallsResponse> fetchHalls() async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/halls',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );
      return HallsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception('Failed to load halls: ${e.response?.statusMessage}');
    }
  }

  Future<Hall> fetchHallDetails(int hallId) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/show_hall',
        data: {'hall_id': hallId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );
      return Hall.fromJson(response.data['hall']);
    } on DioError catch (e) {
      throw Exception('Failed to load hall details: ${e.response?.statusMessage}');
    }
  }

  Future<void> deleteHall(int hallId) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/delete_hall',
        data: {'hall_id': hallId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data['message'] != "hall deleted successfully") {
        throw Exception('Failed to delete hall');
      }
    } on DioError catch (e) {
      throw Exception('Failed to delete hall: ${e.response?.statusMessage}');
    }
  }

  Future<Hall> createHall(String name, String projector, String descreption) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/add_hall',
        data: {
          'name': name,
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
      return Hall.fromJson(response.data['hall']);
    } on DioError catch (e) {
      throw Exception('Failed to create hall: ${e.response?.statusMessage}');
    }
  }

  Future<Hall> updateHall(int hallId, String name, String projector, String descreption) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/update_hall',
        data: {
          'hall_id': hallId,
          'name': name,
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

      return Hall.fromJson(response.data['hall']);
    } on DioError catch (e) {
      print('Failed to update hall: ${e.response?.data}');
      throw Exception('Failed to update hall: ${e.response?.statusMessage}');
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
  Future<List<Reservation>> fetchReservationsByDay(int day) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/formal_day',
        data: {'day': day.toString()},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );


      List<Reservation> reservations = (response.data['formal_day'] as List)
          .map((json) => Reservation.fromJson(json))
          .toList();

      return reservations;
    } on DioError catch (e) {
      print('Dio error: ${e.response?.statusCode} ${e.response?.data}');
      throw Exception('Failed to load reservations: ${e.response?.statusMessage}');
    }
  }
}