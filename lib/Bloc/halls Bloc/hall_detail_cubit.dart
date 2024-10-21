import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/halls_model .dart';
import '../../models/reservation_model.dart';

import '../../services/halls_service.dart';

part 'hall_detail_state.dart';

class HallDetailCubit extends Cubit<HallDetailState> {
  final HallService hallService;

  HallDetailCubit(this.hallService) : super(HallDetailInitial());

  void fetchHallDetails(int hallId) async {
    try {
      emit(HallDetailLoading());
      final hall = await hallService.fetchHallDetails(hallId);
      final reservations = await hallService.fetchReservations(hall.name);
      final doctors = await hallService.fetchDoctors();
      final lectures = await hallService.fetchLectures();
      emit(HallDetailLoaded(hall, reservations, doctors, lectures));
    } catch (e) {
      emit(HallDetailError('Failed to load hall details'));
    }
  }

  void deleteReservation(int reservationId, int hallId) async {
    try {
      emit(HallDetailLoading());
      await hallService.deleteReservation(reservationId);
      final hall = await hallService.fetchHallDetails(hallId);
      final reservations = await hallService.fetchReservations(hall.name);
      final doctors = await hallService.fetchDoctors();
      final lectures = await hallService.fetchLectures();
      emit(HallDetailLoaded(hall, reservations, doctors, lectures));
    } catch (e) {
      emit(HallDetailError('Failed to delete reservation'));
    }
  }

  void updateReservation(int reservationId, String place, String year, String day, String from, String to, String doctor, String lecture, int hallId) async {
    try {
      emit(HallDetailLoading());
      await hallService.updateReservation(reservationId, place, year, day, from, to, doctor, lecture);
      final hall = await hallService.fetchHallDetails(hallId);
      final reservations = await hallService.fetchReservations(hall.name);
      final doctors = await hallService.fetchDoctors();
      final lectures = await hallService.fetchLectures();
      emit(HallDetailLoaded(hall, reservations, doctors, lectures));
    } catch (e) {
      emit(HallDetailError('Failed to update reservation'));
    }
  }

  void addReservation(String place, String year, String day, String from, String to, String doctor, String lecture, int hallId) async {
    try {
      emit(HallDetailLoading());
      await hallService.addReservation(place, year, day, from, to, doctor, lecture);
      final hall = await hallService.fetchHallDetails(hallId);
      final reservations = await hallService.fetchReservations(hall.name);
      final doctors = await hallService.fetchDoctors();
      final lectures = await hallService.fetchLectures();
      emit(HallDetailLoaded(hall, reservations, doctors, lectures));
    } catch (e) {
      emit(HallDetailError('Failed to add reservation'));
    }
  }
}
