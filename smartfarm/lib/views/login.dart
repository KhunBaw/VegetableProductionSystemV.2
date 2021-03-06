// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/models/employee_model.dart';

import '../config/config.dart';
import '../providers/employee_provider.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool checkLogin = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getuser();
    });
  }

  getuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.text = prefs.getString('username') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: kIsWeb ? 500 : MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                // ignore: prefer_const_literals_to_create_immutables
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/mobile_login.svg',
                      height: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      '?????????????????????????????????',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        child: Column(
                          children: [
                            textformlogin('??????????????????????????????', username, false),
                            SizedBox(
                              height: 10,
                            ),
                            textformlogin('????????????????????????', password, true),
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.lightGreen,
                                  value: checkLogin,
                                  onChanged: (value) => setState(() {
                                    checkLogin = value!;
                                  }),
                                ),
                                Text(
                                  '???????????????????????????????????????????????????',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await login();
                      },
                      child: Text('?????????????????????????????????'),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        primary: Colors.lightGreen,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textformlogin(
      String hintText, TextEditingController controller, bool obscureText) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          borderSide: BorderSide(color: Colors.lightGreen, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          borderSide: BorderSide(color: Colors.lightGreen, width: 3),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 18),
        counterStyle: TextStyle(fontSize: 18),
      ),
    );
  }

  Future login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri url = Uri(
      scheme: 'http',
      host: dotenv.env['API_HOST'],
      port: int.parse(dotenv.env['API_PORT']!),
      path: dotenv.env['API_PATH']! + 'login',
    );
    try {
      await http
          .post(
            url,
            headers: headers,
            body: jsonEncode(
              {'username': username.text, 'password': password.text},
            ),
          )
          .timeout(Duration(seconds: 10))
          .then((request) => {
                if (request.statusCode == 200)
                  {
                    print('???????????????????????????????????????'),
                    context
                        .read<Employees>()
                        .setitem(employeeFromJson(request.body)),
                    prefs.setString('username', username.text),
                    prefs.setString(
                        'token', json.decode(request.body)["token"]),
                    prefs.setBool('checkLogin', checkLogin),
                    // checkLogin
                    headers!['Authorization'] =
                        "bearer ${json.decode(request.body)["token"]}",
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                        (route) => false)
                  }
                else if (request.statusCode == 204)
                  {print('???????????????????????????????????????????????????????????????????????????????????????')}
                else if (request.statusCode == 400)
                  {
                    print(
                        '?????????????????????????????????????????? : ${json.decode(request.body)["message"]}')
                  }
              });
    } catch (e) {
      print(e);
    }
  }
}
