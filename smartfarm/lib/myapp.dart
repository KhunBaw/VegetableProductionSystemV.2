import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/index.dart';
import 'routes/routes.dart';
// import 'views/login.dart';
import 'views/splashscreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        home: const SplashScreen(),
        routes: routes,
        theme: ThemeData(
          primaryColor: Colors.lightGreen,
          // backgroundColor: const Color(0xFFf1f1f1),
          scaffoldBackgroundColor: const Color(0xFFf1f1f1),
          fontFamily: 'SF Thonburi',
          appBarTheme: const AppBarTheme(
            color: Colors.lightGreen,
            centerTitle: true,
            titleTextStyle:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.lightGreen),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
      ),
    );
  }
}
