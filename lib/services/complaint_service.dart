import 'package:dio/dio.dart';
import '../core/utils/config.dart';
import '../models/complaint_model.dart';

class ComplaintService {
  final Dio _dio = Dio();

  Future<List<Complaint>> fetchComplaints() async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/my_complaints',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
      );
      List<Complaint> complaints = (response.data['complaints'] as List)
          .map((json) => Complaint.fromJson(json))
          .toList();
      return complaints;
    } on DioError catch (e) {
      throw Exception(
          'Failed to load complaints: ${e.response?.statusMessage}');
    }
  }

  Future<void> updateComplaint(int complaintId, String state) async {
    try {
      final response = await _dio.post(
        '${Config.baseUrl}/control_complaints',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Config.token}',
            'Content-Type': 'application/json',
          },
        ),
        data: {'id': complaintId, 'state': state},
      );
      if (response.data['message'] != "Complaint marked as completed") {
        throw Exception('Failed to update complaint');
      }
    } on DioError catch (e) {
      throw Exception(
          'Failed to update complaint: ${e.response?.statusMessage}');
    }
  }
}
