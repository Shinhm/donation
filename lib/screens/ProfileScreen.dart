import 'package:donation/components/Profile/ProfileInfo.dart';
import 'package:donation/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List donationList = [
    {'name': '후원1'},
    {'name': '후원2'},
    {'name': '후원3'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, child) => Stack(
        children: [
          Container(
            height: ScreenUtil().setHeight(100),
            child: ProfileInfo(
              user: user,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
            child: ListView.builder(
              itemBuilder: (build, index) {
                return ListTile(
                  title: Text(donationList[index]['name'].toString()),
                );
              },
              itemCount: donationList.length,
            ),
          )
        ],
      ),
    );
  }
}
