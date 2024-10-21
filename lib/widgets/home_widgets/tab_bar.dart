import 'package:flutter/material.dart';
import '../../core/utils/color_manager.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  CustomTabBar({required this.tabController});

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: ColorManager.lcolor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: ColorManager.mcolor,
              borderRadius: BorderRadius.circular(6),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: ColorManager.thcolor,
            labelStyle: TextStyle(fontSize: 12),
            tabs: [
              Tab(icon: Icon(Icons.computer, size: 16), text: 'Laboratory Management'),
              Tab(icon: Icon(Icons.library_books, size: 16), text: 'Halls Management'),
              Tab(icon: Icon(Icons.event_available, size: 16), text: 'View reservations'),
            ],
          ),
        ),
      ),
    );
  }
}
