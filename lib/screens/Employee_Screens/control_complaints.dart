
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/complaint_model.dart';
import '../../services/complaint_service.dart';
import '../../Bloc/complaint_cubit.dart';
import '../../core/utils/color_manager.dart';
import '../../widgets/home_widgets/ common_scaffold.dart';

class ControlComplaintsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Control Complaints',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      body: BlocProvider(
        create: (context) => ComplaintCubit(ComplaintService())..fetchComplaints(),
        child: ComplaintList(),
      ),
    );
  }
}

class ComplaintList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintCubit, ComplaintState>(
      builder: (context, state) {
        if (state is ComplaintLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ComplaintLoaded) {
          final complaints = state.complaints;
          if (complaints.isEmpty) {
            return Center(child: Text('No complaints found.'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return Card(
                color: ColorManager.mcolor,
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Place: ${complaint.place}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (complaint.state == 'processing')
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                context.read<ComplaintCubit>().updateComplaint(complaint.id, 'completed');
                              },
                              child: Text(
                                'Complete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(color: Colors.grey),
                      SizedBox(height: 8),
                      _buildDetailRow('Doctor:', complaint.doctorName),
                      _buildDetailRow('Description:', complaint.description),
                      _buildDetailRow('State:', complaint.state),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is ComplaintError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
