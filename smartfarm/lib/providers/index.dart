import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'employee_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => Employees()),
];
