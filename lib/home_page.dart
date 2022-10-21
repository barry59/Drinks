import 'colors.dart';
import 'pages/diy/diyPage.dart';
import 'pages/history/historyPage.dart';
import 'pages/account/accountPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  late List<Widget> listScreens;

  @override
  void initState() {
    super.initState();
    initialization();
    listScreens = [
      const DIYPage(),
      const HistoryPage(),
      const AccountPage(),
    ];
  }

  void initialization() async => FlutterNativeSplash.remove();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreens[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColor.navigationActiveTabItem,
          unselectedItemColor: AppColor.navigationInactiveTabItem,
          backgroundColor: AppColor.navigationTabBackground,
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LineariconsFree.coffee_cup),
              label: 'DIY',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ]),
    );
  }
}
