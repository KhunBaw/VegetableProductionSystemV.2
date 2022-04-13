import 'package:flutter/material.dart';

import '../models/employee_model.dart';

class Employees with ChangeNotifier {
  Employee? _item;

  Employee get item => _item!;

  void setitem(Employee item) {
    _item = item;
    notifyListeners();
  }
}
