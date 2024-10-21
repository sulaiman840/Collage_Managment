
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/halls Bloc/hall_detail_cubit.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/reservation_model.dart';
import '../../../widgets/home_widgets/ common_scaffold.dart';

import '../Laboratory Screens/add_reservation_screen.dart';
import '../Laboratory Screens/update_reservation_screen.dart';
import 'add_reservation_screen_hall.dart';

class HallDetailScreen extends StatefulWidget {
  final int hallId;

  const HallDetailScreen({required this.hallId, Key? key}) : super(key: key);

  @override
  _HallDetailScreenState createState() => _HallDetailScreenState();
}

class _HallDetailScreenState extends State<HallDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<HallDetailCubit>().fetchHallDetails(widget.hallId);
  }

  String getWeekDayName(String dayNumber) {
    switch (dayNumber) {
      case '1':
        return 'Saturday';
      case '2':
        return 'Sunday';
      case '3':
        return 'Monday';
      case '4':
        return 'Tuesday';
      case '5':
        return 'Wednesday';
      case '6':
        return 'Thursday';
      case '7':
        return 'Friday';
      default:
        return 'Unknown';
    }
  }

  void _deleteReservation(int reservationId) {
    context.read<HallDetailCubit>().deleteReservation(reservationId, widget.hallId);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Hall Details',
      scaffoldKey: _scaffoldKey,
      body: BlocBuilder<HallDetailCubit, HallDetailState>(
        builder: (context, state) {
          if (state is HallDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HallDetailLoaded) {
            final hall = state.hall;
            final reservations = state.reservations;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: ColorManager.mcolor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.all( 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${hall.name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Projector: ${hall.projector}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('Description: ${hall.descreption ?? "No descreption"}', style: TextStyle(fontSize: 16)),


                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reservations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: reservations.length,
                          itemBuilder: (context, index) {
                            final reservation = reservations[index];
                            return Card(
                              color: ColorManager.mcolor,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              elevation: 4,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: ColorManager.lcolor,
                                  child: Text(
                                    getWeekDayName(reservation.day).substring(0, 1),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text('Day: ${getWeekDayName(reservation.day)}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Year: ${reservation.year}'),
                                    Text('Lecture: ${reservation.lecture}'),
                                    Text('Doctor: ${reservation.doctor}'),
                                    Text('Place: ${reservation.place}'),
                                    Text('Time: ${reservation.from} - ${reservation.to}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () async {
                                        final updated = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateReservationScreen(
                                              reservation: reservation,
                                              labId: widget.hallId,
                                            ),
                                          ),
                                        );
                                        if (updated == true) {
                                          context.read<HallDetailCubit>().fetchHallDetails(widget.hallId);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm Delete"),
                                              content: Text("Are you sure you want to delete this reservation?"),
                                              actions: [
                                                TextButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("Delete"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _deleteReservation(reservation.id);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () async {
                              final added = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddReservationScreenHall(
                                    labId: widget.hallId,
                                    place: hall.name,
                                  ),
                                ),
                              );
                              if (added == true) {
                                context.read<HallDetailCubit>().fetchHallDetails(widget.hallId);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:  ColorManager.lcolor,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              textStyle: TextStyle(fontSize: 14),
                            ),
                            child: Text('Add Reservation', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HallDetailError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
