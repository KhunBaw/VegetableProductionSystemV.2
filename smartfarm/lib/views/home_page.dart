// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/sidemenu.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: const Text(
          'หน้าแรก',
        ),
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          child: SvgPicture.asset(
            'assets/images/image_bg.svg',
            width: MediaQuery.of(context).size.width,
          ),
        ),
        RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
          },
          color: Colors.lightGreen,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),

            padding: const EdgeInsets.only(top: 10, bottom: 20),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              itemContainer(
                [
                  const Color(0xFF185a9d),
                  const Color(0xFF43cea2),
                ],
                const FaIcon(FontAwesomeIcons.leaf,
                    color: Colors.white, size: 55),
                'ผักที่ปลูกปัจจุบัน 1000 ต้น',
                'เสร็จไปแล้ว 10 ต้น',
              ),
              itemContainer(
                [
                  const Color(0xFF0072ff),
                  const Color(0xFF00c6ff),
                ],
                const FaIcon(FontAwesomeIcons.mapLocation,
                    color: Colors.white, size: 55),
                'พื้นที่ปลูก 1000 แคร่',
                'ใช้งานอยู่ 10 แคร่',
              ),
              itemContainer(
                [
                  const Color(0xFFffb347),
                  const Color(0xFFffcc33),
                ],
                FaIcon(FontAwesomeIcons.store, color: Colors.white, size: 55),
                'คำสั่งซื้อ 1000 รายการ',
                'เสร็จไปแล้ว 10 รายการ',
              ),
              itemContainer(
                [
                  const Color(0xFF7b4397),
                  const Color(0xFFdc2430),
                ],
                FaIcon(FontAwesomeIcons.skullCrossbones,
                    color: Colors.white, size: 55),
                'อัตราสูญเสีย 1 %',
                'จำนวนการสูญเสีย 10 ต้น',
              ),
            ],
          ),
        )
      ]),
      drawer: SideMenu(routeName: HomePage.routeName),
    );
  }

  Container itemContainer(
      List<Color> colors, Widget icon, String? text1, String? text2) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: colors,
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.5, 1.5),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(margin: EdgeInsets.only(left: 30), child: icon),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  text2!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
