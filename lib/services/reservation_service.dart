import 'package:dio/dio.dart';
import '../core/utils/config.dart';
import '../models/reserve_model.dart';

class ReservationService {
  final Dio _dio = Dio();

  Future<List<Reserve>> fetchReservations() async {
    try {
      final response = await _dio.post( '${Config.baseUrl}/my_reserves',
        options: Options(
        headers: {
        'Authorization': 'Bearer ${Config.token}',
        'Content-Type': 'application/json',
        },
      ),
      );

      List<Reserve> reserves = (response.data['reserves'] as List)
          .map((json) => Reserve.fromJson(json))
          .toList();
      return reserves;
    } on DioError catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to load reservations: $e');
    }
  }

  Future<void> updateReservation(int reservationId, String state) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/control_reserve',

        options: Options(
        headers: {
      'Authorization': 'Bearer ${Config.token}',
      'Content-Type': 'application/json',
      },
      ),
        data: {'reserve_id': reservationId, 'state': state},
      );
      if (response.data['message'] != "reserve has update success") {
        throw Exception('Failed to update reservation');
      }
    } on DioError catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to update reservation: $e');
    }
  }

  void _handleDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        print('Connection Timeout Exception: ${e.message}');
        break;
      case DioErrorType.sendTimeout:
        print('Send Timeout Exception: ${e.message}');
        break;
      case DioErrorType.receiveTimeout:
        print('Receive Timeout Exception: ${e.message}');
        break;
      case DioErrorType.response:
        print('Response Exception: ${e.response?.data}');
        break;
      case DioErrorType.cancel:
        print('Request Cancelled Exception: ${e.message}');
        break;
      case DioErrorType.other:
        print('Other Exception: ${e.message}');
        break;
    }
  }
}
