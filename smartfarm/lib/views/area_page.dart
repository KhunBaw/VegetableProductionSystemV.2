import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/sidemenu.dart';

class AreaPage extends StatefulWidget {
  static const String routeName = '/area';
  const AreaPage({Key? key}) : super(key: key);

  @override
  State<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('พื้นที่'),
      ),
      backgroundColor: Colors.lightBlue,
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
            await Future.delayed(const Duration(seconds: 2));
          },
          color: Colors.lightGreen,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            // ignore: prefer_const_literals_to_create_immutables
            children: [],
          ),
        )
      ]),
      drawer: const SideMenu(routeName: AreaPage.routeName),
    );
  }
}
