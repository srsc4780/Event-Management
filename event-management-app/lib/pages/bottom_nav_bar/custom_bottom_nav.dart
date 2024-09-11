import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_tracker/pages/dashboard/view/dashboard_page.dart';
import 'package:sales_tracker/pages/events/event_create.dart';
import 'package:sales_tracker/pages/events/event_list.dart';
import 'package:sales_tracker/pages/profile/view/profile_page.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';
import 'package:sales_tracker/utils/utils.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int? bottomNavigationIndex;

  const CustomBottomNavBar({super.key, this.bottomNavigationIndex});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0; // Default to DashboardPage
  String? barName = "Dashboard";

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    EventListPage(bottomNav: true),
    EventCreatePage(),
    ProfilePage(bottomNav: true),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.bottomNavigationIndex != null) {
      selectedIndex = widget.bottomNavigationIndex!;
    }
    appBarName(selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      appBarName(selectedIndex);
    });
  }

  void appBarName(int index) {
    switch (index) {
      case 0:
        barName = "Dashboard";
        break;
      case 1:
        barName = "Events List";
        break;
      case 2:
        barName = "Create Event";
        break;
      case 3:
        barName = "Profile";
        break;
      default:
        barName = "Dashboard";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final differences = DateTime.now().difference(timeBackPressed);
        timeBackPressed = DateTime.now();
        if (differences >= const Duration(seconds: 2)) {
          Fluttertoast.showToast(msg: "Press the back button again to exit");
          return false;
        } else {
          Fluttertoast.cancel();
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(barName ?? "Dashboard"),
        ),
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(1, 1),
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            elevation: 2,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(color: primarySolidColor),
            selectedItemColor: primarySolidColor,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined,
                  size: 24.h,
                  color: selectedIndex == 0 ? primarySolidColor : Colors.grey,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 1 ? Icons.list_alt : Icons.list,
                  size: 24.h,
                  color: selectedIndex == 1 ? primarySolidColor : Colors.grey,
                ),
                label: 'Events List',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 1 ? Icons.add : Icons.add,
                  size: 24.h,
                  color: selectedIndex == 1 ? primarySolidColor : Colors.grey,
                ),
                label: 'Create Event',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 3 ? Icons.person : Icons.person_outline,
                  size: 24.h,
                  color: selectedIndex == 3 ? primarySolidColor : Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              _onItemTapped(index);
            },
          ),
        ),
      ),
    );
  }
}
