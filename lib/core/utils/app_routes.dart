import 'package:flutter/material.dart';
import 'package:itcollage/screens/Employee_Screens/control_complaints.dart';
import 'package:itcollage/screens/Employee_Screens/control_reservre.dart';
import 'package:itcollage/screens/Home/employee_home.dart';

class AppRouter {
  static const String home = '/';
  static const String controlComplaints = '/control_complaints';
  static const String controlReserve = '/control_reserve';

  static final routes = <String, WidgetBuilder>{
    home: (context) => EmployeeHome(),
    controlComplaints: (context) => ControlComplaintsScreen(),
    controlReserve: (context) => ControlReserveScreen(),
  };
}
