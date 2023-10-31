import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'pages/favorites/view.dart';
import 'pages/main/view.dart';
import 'pages/my_account/view.dart';
import 'pages/my_orders/view.dart';
import 'pages/notifications/view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 2;
  List<Widget> pages = [
    MainPage(),
    MyOrdersPages(),
    NotificationPage(),
    FavoraitesPage(),
    MyAccountPage(),
  ];

  List<String> titles = [
    "الرئيسية",
    "طلباتي",
    "الإشعارات",
    "المفضلة",
    "حسابي",
  ];

  List<String> icons = [
    "home_icon",
    "my_orders_icon",
    "notification_icon",
    "fav_icon",
    "user_icon",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: currentIndex,
        unselectedItemColor: Color(0xffAED489),
        selectedItemColor: Colors.white,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        items: List.generate(pages.length, (index) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/svg/${icons[index]}.svg",
            color: currentIndex == 0 ? Colors.white : Color(0xffAED489),
          ),
          label: titles[index],
        ),) ,
      ),
    );
  }
}
