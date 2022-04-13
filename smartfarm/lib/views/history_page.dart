import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/sidemenu.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = '/history';
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติการปลูก'),
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
      drawer: const SideMenu(routeName: HistoryPage.routeName),
    );
  }
}
