import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/lab_model.dart';
import '../../services/lab_service.dart';

part 'lab_state.dart';

class LabCubit extends Cubit<LabState> {
  final LabService labService;

  LabCubit(this.labService) : super(LabInitial());

  void fetchLabs() async {
    try {
      emit(LabLoading());
      final labs = await labService.fetchLabs();
      emit(LabLoaded(labs.labs));
    } catch (e) {
      emit(LabError('Failed to load labs'));
    }
  }

  void deleteLab(int labId) async {
    try {
      emit(LabLoading());
      await labService.deleteLab(labId);
      final labs = await labService.fetchLabs();
      emit(LabLoaded(labs.labs));
    } catch (e) {
      emit(LabError('Failed to delete lab'));
    }
  }

  void createLab(String name, int pcNumber, String projector, String descreption) async {
    try {
      emit(LabLoading());
      await labService.createLab(name, pcNumber, projector, descreption);
      final labs = await labService.fetchLabs();
      emit(LabLoaded(labs.labs));
    } catch (e) {
      emit(LabError('Failed to create lab'));
    }
  }

  void updateLab(int labId, String name, int pcNumber, String projector, String descreption) async {
    try {
      emit(LabLoading());
      await labService.updateLab(labId, name, pcNumber, projector, descreption);
      final labs = await labService.fetchLabs();
      emit(LabLoaded(labs.labs));
    } catch (e) {
      emit(LabError('Failed to update lab'));
    }
  }
}
