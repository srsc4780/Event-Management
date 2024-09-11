import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_tracker/pages/dashboard/view/dashboard_page.dart';
import 'package:sales_tracker/utils/theme/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  final int? bottomNavigationIndex;

  const BottomNavBar({super.key, this.bottomNavigationIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool expended = false;
  int selectedIndex = 0;
  String? barName = "Home";
  int currentScreenIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    FlutterLogo(),
    FlutterLogo(),
    FlutterLogo(),
    FlutterLogo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      appBarName(selectedIndex);
    });
  }

  void appBarName(int radians) {
    switch (radians) {
      case 0:
        barName = "Home";
        break;
      case 1:
        barName = "Instructor";
        break;
      case 2:
        barName = "Dashboard";
        break;
      case 3:
        barName = "All Courses";
        break;
      case 4:
        barName = "Profile";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    // ignore: unused_local_variable
    final PageController myPage =
        PageController(initialPage: widget.bottomNavigationIndex ?? 2);
    return WillPopScope(
      onWillPop: () async {
        final differences = DateTime.now().difference(timeBackPressed);
        timeBackPressed = DateTime.now();
        if (differences >= const Duration(seconds: 2)) {
          String msg = "Press the back button to exit";
          Fluttertoast.showToast(
            msg: msg,
          );
          return false;
        } else {
          Fluttertoast.cancel();
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor:
                selectedIndex == 2 ? primarySolidColor : Colors.white,
            child:
                // const Icon(Icons.menu),
                Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.add,
                color: selectedIndex == 2 ? white : primarySolidColor,
              ),
            ),
            onPressed: () {
              // NavUtil.navigateScreen(context, MenuScreen());
              setState(() {
                expended = true;
                myPage.jumpToPage(2);
                selectedIndex = 2;
              });
            }),
        // drawer: const AppDrawer(),
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(70.h),
        //   child: CustomAppBar(
        //     appBarName: barName,
        //   ),
        // ),
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
            elevation: 2,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(color: primarySolidColor),
            selectedItemColor: primarySolidColor,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: selectedIndex == 0
                    ? Image.asset(
                        'assets/icon/home_red.png',
                        height: 24.h,
                        width: 24.w,
                      )
                    : Image.asset(
                        'assets/icon/home_black.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 1
                    ? Image.asset(
                        'assets/icon/cart_red.png',
                        height: 24.h,
                        width: 24.w,
                      )
                    : Image.asset(
                        'assets/icon/cart_black.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                // Image.asset(
                //   'assets/images/bottomnavbar/Search.png',
                //   height: 24.h,
                //   width: 24.w,
                // ),
                label: '',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.abc, color: Colors.transparent),

                  // Image.asset(
                  //   'assets/images/bottomnavbar/heart.png',
                  //   height: 24.h,
                  //   width: 24.w,
                  // ),
                  label: ''),
              BottomNavigationBarItem(
                icon: selectedIndex == 3
                    ? Image.asset(
                        'assets/icon/document_red.png',
                        height: 24.h,
                        width: 24.w,
                      )
                    : Image.asset(
                        'assets/icon/document_black.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 4
                    ? Image.asset(
                        'assets/icon/profile_red.png',
                        height: 24.h,
                        width: 24.w,
                      )
                    : Image.asset(
                        'assets/icon/profile_black.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                // Image.asset(
                //   'assets/images/profile (1).png',
                //   height: 24.h,
                //   width: 24.w,
                // ),
                label: '',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
