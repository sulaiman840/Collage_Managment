import 'package:flutter/material.dart';
import '../../core/utils/color_manager.dart';
import '../../widgets/home_widgets/custom_tab_bar_view.dart';
import '../../widgets/home_widgets/main_nav_bar.dart';
import '../../widgets/home_widgets/tab_bar.dart';
import '../Employee_Screens/Halls Screens/halls_management.dart';
import '../Employee_Screens/Laboratory Screens/laboratory_management.dart';
import '../Employee_Screens/reservation_screen.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({super.key});

  @override
  _EmployeeHomeState createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 600;
    bool isShortScreen = screenHeight < 145;

    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      appBar: isMobile ? AppBar(title: Text("Dashboard")) : null,
      drawer: isMobile ? MainNavBar() : null,
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 200,
              color: Colors.black,
              child: MainNavBar(),
            ),
          Expanded(
            child: Column(
              children: [
                if (!isMobile && !isShortScreen)
                  Container(
                    color: ColorManager.hcolor,
                    child: CustomTabBar(tabController: _tabController),
                  ),
                Expanded(
                  child: Container(
                    color: ColorManager.hcolor,
                    child: CustomTabBarView(tabController: _tabController),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
