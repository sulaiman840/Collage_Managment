part of 'lab_cubit.dart';

@immutable
abstract class LabState {}

class LabInitial extends LabState {}

class LabLoading extends LabState {}

class LabLoaded extends LabState {
  final List<Lab> labs;

  LabLoaded(this.labs);
}

class LabError extends LabState {
  final String message;

  LabError(this.message);
}
