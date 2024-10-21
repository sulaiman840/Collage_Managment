import 'package:flutter/material.dart';
import '../../core/utils/color_manager.dart';
import 'custom_app_bar.dart';
import 'main_nav_bar.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CommonScaffold({required this.title, required this.body, required this.scaffoldKey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: ColorManager.hcolor,
      key: scaffoldKey,
      appBar: isMobile ? CustomAppBar(scaffoldKey: scaffoldKey) : null,
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
                if (!isMobile)
                  Container(
                    color: ColorManager.thcolor,
                    child: AppBar(
                      title: Text(title, style: TextStyle(color: ColorManager.lcolor)),
                      backgroundColor: ColorManager.hcolor,
                      centerTitle: true,
                    ),
                  ),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
