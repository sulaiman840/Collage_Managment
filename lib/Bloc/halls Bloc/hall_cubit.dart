import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/halls_model .dart';
import '../../services/halls_service.dart';

part 'hall_state.dart';

class HallCubit extends Cubit<HallState> {
  final HallService hallService;

  HallCubit(this.hallService) : super(HallInitial());

  void fetchHalls() async {
    try {
      emit(HallLoading());
      final halls = await hallService.fetchHalls();
      emit(HallLoaded(halls.halls));
    } catch (e) {
      emit(HallError('Failed to load halls'));
    }
  }

  void deleteHall(int hallId) async {
    try {
      emit(HallLoading());
      await hallService.deleteHall(hallId);
      final halls = await hallService.fetchHalls();
      emit(HallLoaded(halls.halls));
    } catch (e) {
      emit(HallError('Failed to delete hall'));
    }
  }

  void createHall(String name, String projector, String descreption) async {
    try {
      emit(HallLoading());
      await hallService.createHall(name, projector, descreption);
      final halls = await hallService.fetchHalls();
      emit(HallLoaded(halls.halls));
    } catch (e) {
      emit(HallError('Failed to create hall'));
    }
  }

  void updateHall(int hallId, String name, String projector, String descreption) async {
    try {
      emit(HallLoading());
      await hallService.updateHall(hallId, name, projector, descreption);
      final halls = await hallService.fetchHalls();
      emit(HallLoaded(halls.halls));
    } catch (e) {
      emit(HallError('Failed to update hall'));
    }
  }
}
