import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/lab_model.dart';
import '../../models/reservation_model.dart';
import '../../services/lab_service.dart';

part 'lab_detail_state.dart';

class LabDetailCubit extends Cubit<LabDetailState> {
  final LabService labService;

  LabDetailCubit(this.labService) : super(LabDetailInitial());

  void fetchLabDetails(int labId) async {
    try {
      emit(LabDetailLoading());
      final lab = await labService.fetchLabDetails(labId);
      final reservations = await labService.fetchReservations(lab.name);
      final doctors = await labService.fetchDoctors();
      final lectures = await labService.fetchLectures();
      emit(LabDetailLoaded(lab, reservations, doctors, lectures));
    } catch (e) {
      emit(LabDetailError('Failed to load lab details'));
    }
  }

  void deleteReservation(int reservationId, int labId) async {
    try {
      emit(LabDetailLoading());
      await labService.deleteReservation(reservationId);
      final lab = await labService.fetchLabDetails(labId);
      final reservations = await labService.fetchReservations(lab.name);
      final doctors = await labService.fetchDoctors();
      final lectures = await labService.fetchLectures();
      emit(LabDetailLoaded(lab, reservations, doctors, lectures));
    } catch (e) {
      emit(LabDetailError('Failed to delete reservation'));
    }
  }

  void updateReservation(int reservationId, String place, String year, String day, String from, String to, String doctor, String lecture, int labId) async {
    try {
      emit(LabDetailLoading());
      await labService.updateReservation(reservationId, place, year, day, from, to, doctor, lecture);
      final lab = await labService.fetchLabDetails(labId);
      final reservations = await labService.fetchReservations(lab.name);
      final doctors = await labService.fetchDoctors();
      final lectures = await labService.fetchLectures();
      emit(LabDetailLoaded(lab, reservations, doctors, lectures));
    } catch (e) {
      emit(LabDetailError('Failed to update reservation'));
    }
  }

  void addReservation(String place, String year, String day, String from, String to, String doctor, String lecture, int labId) async {
    try {
      emit(LabDetailLoading());
      await labService.addReservation(place, year, day, from, to, doctor, lecture);
      final lab = await labService.fetchLabDetails(labId);
      final reservations = await labService.fetchReservations(lab.name);
      final doctors = await labService.fetchDoctors();
      final lectures = await labService.fetchLectures();
      emit(LabDetailLoaded(lab, reservations, doctors, lectures));
    } catch (e) {
      emit(LabDetailError('Failed to add reservation'));
    }
  }
}
