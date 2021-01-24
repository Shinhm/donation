import 'package:donation/models/User.dart';
import 'package:donation/providers/DatabaseProvider.dart';
import 'package:donation/providers/IndexProvider.dart';
import 'package:donation/screens/AdScreen.dart';
import 'package:donation/screens/ProfileScreen.dart';
import 'package:donation/services/DeviceService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firestore 초기화
  IndexProvider ip = IndexProvider();
  ip.initFireStore();
  final DeviceService ds = DeviceService();
  String deviceId = await ds.getId();
  runApp(MyApp(deviceId: deviceId));
}

class MyApp extends StatefulWidget {
  MyApp({this.deviceId});

  final String deviceId;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DatabaseProvider db = DatabaseProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<User>.value(
          value: db.getUserIfExist(widget.deviceId),
        )
      ],
      child: GetMaterialApp(
        title: 'donation app',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(75, 0, 130, 1),
        ),
        home: PageViewScreen(),
      ),
    );
  }
}

class PageViewScreen extends StatefulWidget {
  PageViewScreen();

  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController _controller = PageController(
    initialPage: 0,
  );
  int bottomSelectedIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      _controller.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 375, height: 812);
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        onPageChanged: (index) {
          pageChanged(index);
        },
        controller: _controller,
        children: [
          ProfileScreen(),
          AdScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('내 정보')),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video), title: Text('광고')),
        ],
      ),
    );
  }
}
