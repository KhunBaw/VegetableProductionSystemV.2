import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/sidemenu.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = '/order';
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คำสั่งซื้อ'),
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
      drawer: SideMenu(routeName: OrderPage.routeName),
    );
  }
}
