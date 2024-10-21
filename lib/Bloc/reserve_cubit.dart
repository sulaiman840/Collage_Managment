import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/reserve_model.dart';
import '../../services/reservation_service.dart';

part 'reserve_state.dart';

class ReserveCubit extends Cubit<ReserveState> {
  final ReservationService reservationService;

  ReserveCubit(this.reservationService) : super(ReserveInitial());

  void fetchReservations() async {
    try {
      emit(ReserveLoading());
      final reserves = await reservationService.fetchReservations();
      emit(ReserveLoaded(reserves));
    } catch (e) {
      emit(ReserveError('Failed to load reservations'));
    }
  }

  void updateReservation(int reservationId, String state) async {
    try {
      emit(ReserveLoading());
      await reservationService.updateReservation(reservationId, state);
      final reserves = await reservationService.fetchReservations();
      emit(ReserveLoaded(reserves));
    } catch (e) {
      emit(ReserveError('Failed to update reservation'));
    }
  }
}
