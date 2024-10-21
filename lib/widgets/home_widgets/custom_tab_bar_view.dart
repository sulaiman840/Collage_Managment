import 'package:flutter/material.dart';
import 'package:itcollage/screens/Employee_Screens/Halls%20Screens/halls_management.dart';
import '../../screens/Employee_Screens/Laboratory Screens/laboratory_management.dart';
import '../../screens/Employee_Screens/reservation_screen.dart';

class CustomTabBarView extends StatelessWidget {
  final TabController tabController;

  CustomTabBarView({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        LaboratoryManagement(),
        HallManagement(),
        ReservationScreen(),
      ],
    );
  }
}
