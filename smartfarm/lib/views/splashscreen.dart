// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../models/employee_model.dart';
import '../providers/employee_provider.dart';
import 'home_page.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? status = 'กำลังเริ่มต้น';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // start();
    chackLogin();
  }

  changeStatus(String st) => setState(() {
        status = st;
      });

  start(bool status) async {
    changeStatus('กำลังเปลียนหน้า');
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  status ? const HomePage() : const LoginPage(),
            ),
            (route) => false);
      },
    );
  }

  chackLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? checkLogin = prefs.getBool('checkLogin');
    checkLogin ??= false;
    if (!checkLogin) return start(false);
    changeStatus('ดึงข้อมูล Token');
    String? token = prefs.getString('token');
    if (token == null) return start(false);
    Uri url = Uri(
      scheme: 'http',
      host: dotenv.env['API_HOST'],
      port: int.parse(dotenv.env['API_PORT']!),
      path: dotenv.env['API_PATH']! + 'login',
    );
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      // Authorize Header
      "Authorization": "bearer $token",
    };

    try {
      changeStatus('กำลังเช็ค Token');
      await http.get(url, headers: header).timeout(
        const Duration(seconds: 15),
        onTimeout: () async {
          changeStatus('หมดเวลาการเชื่อมต่อ\nไม่สามารถเชื่อมต่อเซิฟเวอร์ได้');
          throw ('Timeout');
        },
      ).then((request) => {
            if (request.statusCode == 200)
              {
                changeStatus('Token ผ่านการตรวจสอบ'),
                prefs.setString('token', json.decode(request.body)["token"]),
                headers = header,
                print('ล็อคอินสำเร็จ'),
                context
                    .read<Employees>()
                    .setitem(employeeFromJson(request.body)),
                start(true),
              }
            else if (request.statusCode == 400)
              {
                changeStatus('เกิดข้อผิดพลาด'),
                print(
                    'เกิดข้อผิดพลาด : ${json.decode(request.body)["message"]}'),
                prefs.remove('token'),
                start(false),
              }
          });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: 50,
            child: Image.asset(
              'assets/icons/app_icon.png',
              height: 300,
            ),
          ),
          Positioned(
              bottom: 100,
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    status!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[800]),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
