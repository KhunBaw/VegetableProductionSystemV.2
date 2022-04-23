// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../providers/employee_provider.dart';
import '../views/alet_history_page.dart';
import '../views/area_page.dart';
import '../views/history_page.dart';
import '../views/home_page.dart';
import '../views/login.dart';
import '../views/order_page.dart';
import '../views/planting_record_page.dart';

class SideMenu extends StatefulWidget {
  SideMenu({
    Key? key,
    this.routeName,
  }) : super(key: key);

  final String? routeName;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    super.initState();
  }

  String getUrlImage(String name) {
    Uri url = Uri(
      scheme: 'http',
      host: dotenv.env['API_HOST'],
      port: int.parse(dotenv.env['API_PORT']!),
      path: dotenv.env['API_PATH']! + 'employee/profile/' + name,
    );
    return url.toString();
  }

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
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        getUrlImage(
                          context.watch<Employees>().item.empPhoto!,
                        ),
                        headers: headers,
                      ),
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
      selected: widget.routeName == routeItemName,
      selectedColor: Colors.lightGreen,
      leading: leading,
      title: Text(name),
      onTap: () {
        widget.routeName == routeItemName
            ? Navigator.pop(context, true)
            : Navigator.pushReplacementNamed(context, routeItemName);
      },
    );
  }
}
