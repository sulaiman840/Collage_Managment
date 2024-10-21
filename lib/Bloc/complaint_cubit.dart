import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/complaint_model.dart';
import '../../services/complaint_service.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  final ComplaintService complaintService;

  ComplaintCubit(this.complaintService) : super(ComplaintInitial());

  void fetchComplaints() async {
    try {
      emit(ComplaintLoading());
      final complaints = await complaintService.fetchComplaints();
      emit(ComplaintLoaded(complaints));
    } catch (e) {
      emit(ComplaintError('Failed to load complaints'));
    }
  }

  void updateComplaint(int complaintId, String state) async {
    try {
      emit(ComplaintLoading());
      await complaintService.updateComplaint(complaintId, state);
      final complaints = await complaintService.fetchComplaints();
      emit(ComplaintLoaded(complaints));
    } catch (e) {
      emit(ComplaintError('Failed to update complaint'));
    }
  }
}
