part of 'reserve_cubit.dart';

@immutable
abstract class ReserveState {}

class ReserveInitial extends ReserveState {}

class ReserveLoading extends ReserveState {}

class ReserveLoaded extends ReserveState {
  final List<Reserve> reserves;

  ReserveLoaded(this.reserves);
}

class ReserveError extends ReserveState {
  final String message;

  ReserveError(this.message);
}
