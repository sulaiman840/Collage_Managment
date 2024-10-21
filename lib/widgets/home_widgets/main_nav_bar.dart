import 'package:flutter/material.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/color_manager.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        color: ColorManager.lcolor,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/unknown.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'IT Collage Management',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.4)),
            Flexible(
              flex: 3,
              child: ListView(
                children: [
                  _buildNavItem(Icons.dashboard, 'Dashboard', context, AppRouter.home),
                  _buildNavItem(Icons.calendar_today, 'Control Reserve', context, AppRouter.controlReserve),
                  _buildNavItem(Icons.report_problem, 'Control Complaints', context, AppRouter.controlComplaints),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, BuildContext context, String route) {
    bool isSelected = ModalRoute.of(context)?.settings.name == route;

    return Container(
      color: isSelected ? Colors.teal.withOpacity(0.3) : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 30),
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 19)),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}
