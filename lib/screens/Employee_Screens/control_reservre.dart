import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/reserve_model.dart';
import '../../services/reservation_service.dart';
import '../../Bloc/reserve_cubit.dart';
import '../../core/utils/color_manager.dart';
import '../../widgets/home_widgets/ common_scaffold.dart';

class ControlReserveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Control Reservations From Doctors',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      body: BlocProvider(
        create: (context) => ReserveCubit(ReservationService())..fetchReservations(),
        child: ReservationList(),
      ),
    );
  }
}

class ReservationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReserveCubit, ReserveState>(
      builder: (context, state) {
        if (state is ReserveLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ReserveLoaded) {
          final reserves = state.reserves;
          if (reserves.isEmpty) {
            return Center(child: Text('No reservations found.'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: reserves.length,
            itemBuilder: (context, index) {
              final reserve = reserves[index];
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
                            'Place: ${reserve.place}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (reserve.state == 'processing')
                            Row(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<ReserveCubit>().updateReservation(reserve.id, 'accept');
                                  },
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<ReserveCubit>().updateReservation(reserve.id, 'reject');
                                  },
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(color: Colors.grey),
                      SizedBox(height: 8),
                      _buildDetailRow('Doctor:', reserve.doctorName),
                      _buildDetailRow('From:', reserve.from),
                      _buildDetailRow('To:', reserve.to),
                      _buildDetailRow('Date:', reserve.date),
                      _buildDetailRow('Reason:', reserve.reason),
                      _buildDetailRow('State:', reserve.state),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is ReserveError) {
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
