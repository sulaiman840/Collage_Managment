part of 'hall_detail_cubit.dart';

@immutable
abstract class HallDetailState {}

class HallDetailInitial extends HallDetailState {}

class HallDetailLoading extends HallDetailState {}

class HallDetailLoaded extends HallDetailState {
  final Hall hall;
  final List<Reservation> reservations;
  final List<String> doctors;
  final List<String> lectures;

  HallDetailLoaded(this.hall, this.reservations, this.doctors, this.lectures);
}

class HallDetailError extends HallDetailState {
  final String message;

  HallDetailError(this.message);
}
