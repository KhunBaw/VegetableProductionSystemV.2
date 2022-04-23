// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timelines/timelines.dart';

import '../components/sidemenu.dart';

class PlantingRecord extends StatefulWidget {
  static const String routeName = '/planting_record';
  const PlantingRecord({Key? key}) : super(key: key);

  @override
  State<PlantingRecord> createState() => _PlantingRecordState();
}

class _PlantingRecordState extends State<PlantingRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('บันทึกการปลูก'),
        // elevation: 0,
      ),
      backgroundColor: Colors.lightBlue,
      body: Stack(alignment: AlignmentDirectional.center, children: [
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
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  elevation: 10,
                  primary: Colors.white,
                  onPrimary: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20, child: _Timeline1()),
                      RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                              children: [
                            TextSpan(
                                text: 'หมายเลขการปลูก : ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '123456789'),
                          ])),
                      RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                              children: [
                            TextSpan(
                                text: 'คำสั่งซื้อ : ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '123456789'),
                          ])),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.calendarDay,
                              color: Colors.blue, size: 20),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '1/12/2564',
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          FaIcon(FontAwesomeIcons.calendarCheck,
                              color: Colors.blue, size: 20),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '1/12/2564',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.locationDot,
                              color: Colors.red, size: 20),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'A3',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.seedling,
                              color: Colors.lightGreen[600], size: 20),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'เคลใบหยิก : 4 ต้น : 12.0 Kg',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
      drawer: SideMenu(routeName: PlantingRecord.routeName),
    );
  }
}

class _Timeline1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = ['a', 'b', 'c', 'd', 'e'];
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        direction: Axis.horizontal,
        connectorTheme: ConnectorThemeData(
          space: 5.0,
          thickness: 2.0,
          color: Color(0xffd3d3d3),
        ),
        nodePosition: 0,
        indicatorTheme: IndicatorThemeData(
          size: 15.0,
        ),
      ),
      // padding: EdgeInsets.symmetric(horizontal: 0),
      builder: TimelineTileBuilder.connected(
        // contentsBuilder: (_, __) => _EmptyContents(),
        connectorBuilder: (_, index, __) {
          if (index == 0) {
            return SolidLineConnector(color: Color(0xff6ad192));
          } else {
            return SolidLineConnector();
          }
        },
        indicatorBuilder: (_, index) {
          switch (data[index]) {
            case 'a':
              return DotIndicator(
                color: Color(0xff6ad192),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 10.0,
                ),
              );
            case 'b':
              return DotIndicator(
                color: Color(0xff193fcc),
                child: Icon(
                  Icons.sync,
                  size: 10.0,
                  color: Colors.white,
                ),
              );
            default:
              return OutlinedDotIndicator(
                color: Color(0xffbabdc0),
                backgroundColor: Color(0xffe6e7e9),
              );
          }
        },
        itemExtentBuilder: (_, __) => 340 / data.length,
        itemCount: data.length,
      ),
    );
  }
}
