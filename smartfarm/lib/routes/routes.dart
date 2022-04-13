import 'package:flutter/material.dart';

import '../views/alet_history_page.dart';
import '../views/area_page.dart';
import '../views/history_page.dart';
import '../views/home_page.dart';
import '../views/order_page.dart';
import '../views/planting_record_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.routeName: (context) => const HomePage(),
  PlantingRecord.routeName: (context) => const PlantingRecord(),
  OrderPage.routeName: (context) => const OrderPage(),
  AreaPage.routeName: (context) => const AreaPage(),
  AletHistory.routeName: (context) => const AletHistory(),
  HistoryPage.routeName: (context) => const HistoryPage(),
};
