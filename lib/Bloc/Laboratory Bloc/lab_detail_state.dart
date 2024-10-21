part of 'lab_detail_cubit.dart';

@immutable
abstract class LabDetailState {}

class LabDetailInitial extends LabDetailState {}

class LabDetailLoading extends LabDetailState {}

class LabDetailLoaded extends LabDetailState {
  final Lab lab;
  final List<Reservation> reservations;
  final List<String> doctors;
  final List<String> lectures;

  LabDetailLoaded(this.lab, this.reservations, this.doctors, this.lectures);
}

class LabDetailError extends LabDetailState {
  final String message;

  LabDetailError(this.message);
}
