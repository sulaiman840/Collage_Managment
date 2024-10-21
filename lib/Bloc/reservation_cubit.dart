import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/reservation_model.dart';
import '../services/halls_service.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final HallService hallService;

  ReservationCubit(this.hallService) : super(ReservationInitial());

  void fetchReservationsByDay(int day) async {
    try {
      emit(ReservationLoading());
      final reservations = await hallService.fetchReservationsByDay(day);
      emit(ReservationLoaded(reservations));
    } catch (e) {
      print('Error fetching reservations: $e'); // Debug statement
      emit(ReservationError('Failed to load reservations'));
    }
  }
}
