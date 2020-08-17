import 'package:donation/screens/HomeScreen.dart';
import 'package:donation/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'donation app',
      home: PageViewScreen(),
    );
  }
}

class PageViewScreen extends StatefulWidget {
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
    // TODO: implement initState
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
      appBar: AppBar(
      ),
      body: PageView(
        onPageChanged: (index) {
          pageChanged(index);
        },
        controller: _controller,
        children: [
          HomeScreen(),
          Text('chart'),
//          Container(child: Text('profile')),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('홈')),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), title: Text('차트')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('내 정보')),
        ],
      ),
    );
  }
}
