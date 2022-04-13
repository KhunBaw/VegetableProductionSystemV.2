// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/employee_provider.dart';
import '../views/alet_history_page.dart';
import '../views/area_page.dart';
import '../views/history_page.dart';
import '../views/home_page.dart';
import '../views/login.dart';
import '../views/order_page.dart';
import '../views/planting_record_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    this.routeName,
  }) : super(key: key);

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Colors.lightGreen,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.ninenik.com/images/ninenik_page_logo.jpg"),
                      backgroundColor: Colors.white,
                      radius: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${context.watch<Employees>().item.username}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${context.watch<Employees>().item.empName}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                routeItem(
                  context,
                  Icon(FontAwesomeIcons.house),
                  'หน้าแรก',
                  HomePage.routeName,
                ),
                routeItem(
                  context,
                  Icon(FontAwesomeIcons.briefcase),
                  'บันทึกการปลูก',
                  PlantingRecord.routeName,
                ),
                routeItem(
                  context,
                  Icon(FontAwesomeIcons.cartShopping),
                  'คำสั่งซื้อ',
                  OrderPage.routeName,
                ),
                routeItem(
                  context,
                  Icon(FontAwesomeIcons.locationDot),
                  'พื้นที่',
                  AreaPage.routeName,
                ),
                routeItem(
                  context,
                  Icon(FontAwesomeIcons.calendarDay),
                  'แจ้งเตือน',
                  AletHistory.routeName,
                ),
                routeItem(
                  context,
                  Icon(FontAwesomeIcons.clockRotateLeft),
                  'ประวัติการปลูก',
                  HistoryPage.routeName,
                ),
                routeItem(
                  context,
                  Icon(FontAwesomeIcons.solidCircleUser),
                  'ประวัติส่วนตัว',
                  HistoryPage.routeName,
                ),
                Visibility(
                  visible: context.watch<Employees>().item.role == 'admin',
                  // visible: false,
                  child: Column(
                    children: [
                      Divider(
                        thickness: 3,
                        color: Colors.lightGreen,
                      ),
                      Text(
                        'Admin',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.lightGreen,
                      ),
                      routeItem(
                        context,
                        Icon(FontAwesomeIcons.calendarDay),
                        'แจ้งเตือน',
                        AletHistory.routeName,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.lightGreen,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(FontAwesomeIcons.rightFromBracket),
                  title: Text('ออกจากระบบ'),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('token');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile routeItem(BuildContext context, Widget? leading, String name,
      String routeItemName) {
    return ListTile(
      selected: routeName == routeItemName,
      selectedColor: Colors.lightGreen,
      leading: leading,
      title: Text(name),
      onTap: () {
        routeName == routeItemName
            ? Navigator.pop(context, true)
            : Navigator.pushReplacementNamed(context, routeItemName);
      },
    );
  }
}
