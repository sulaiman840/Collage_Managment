part of 'hall_cubit.dart';

@immutable
abstract class HallState {}

class HallInitial extends HallState {}

class HallLoading extends HallState {}

class HallLoaded extends HallState {
  final List<Hall> halls;

  HallLoaded(this.halls);
}

class HallError extends HallState {
  final String message;

  HallError(this.message);
}
