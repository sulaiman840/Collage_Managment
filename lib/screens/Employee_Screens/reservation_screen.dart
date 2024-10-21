
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/reservation_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../Bloc/reservation_cubit.dart';
import '../../services/halls_service.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.hcolor,
      appBar: AppBar(
        title: Text('Reservations by Day', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: ColorManager.hcolor,
      ),
      body: DefaultTabController(
        length: 7,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorManager.lcolor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: ColorManager.mcolor,
                  borderRadius: BorderRadius.circular(6),
                ),
                isScrollable: false,
                labelColor:  Colors.white,
                unselectedLabelColor: ColorManager.thcolor,
                labelStyle: TextStyle(fontSize: 12),
                tabs: [
                  Tab(text: 'Saturday'),
                  Tab(text: 'Sunday'),
                  Tab(text: 'Monday'),
                  Tab(text: 'Tuesday'),
                  Tab(text: 'Wednesday'),
                  Tab(text: 'Thursday'),
                  Tab(text: 'Friday'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(7, (index) {
                  return BlocProvider(
                    create: (context) => ReservationCubit(HallService())..fetchReservationsByDay(index + 1),
                    child: ReservationList(day: index + 1),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReservationList extends StatelessWidget {
  final int day;

  const ReservationList({required this.day});

  String getWeekDayName(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return 'Saturday';
      case 2:
        return 'Sunday';
      case 3:
        return 'Monday';
      case 4:
        return 'Tuesday';
      case 5:
        return 'Wednesday';
      case 6:
        return 'Thursday';
      case 7:
        return 'Friday';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationCubit, ReservationState>(
      builder: (context, state) {
        if (state is ReservationLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ReservationLoaded) {
          final reservations = state.reservations;
          if (reservations.isEmpty) {
            return Center(child: Text('No reservations found for this day.'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              return Card(
                color: ColorManager.mcolor,
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundColor: ColorManager.lcolor,
                    child: Text(
                      getWeekDayName(day).substring(0, 1),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    'Day: ${getWeekDayName(int.parse(reservation.day))}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Year: ${reservation.year}', style: TextStyle(fontSize: 14)),
                        Text('Lecture: ${reservation.lecture}', style: TextStyle(fontSize: 14)),
                        Text('Doctor: ${reservation.doctor}', style: TextStyle(fontSize: 14)),
                        Text('Place: ${reservation.place}', style: TextStyle(fontSize: 14)),
                        Text('Time: ${reservation.from} - ${reservation.to}', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is ReservationError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
