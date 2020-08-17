import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: ScreenUtil().setHeight(100),
          child: Row(
            children: [
              Container(
                  width: ScreenUtil().setWidth(100),
                  child: Icon(
                    Icons.account_circle,
                    size: ScreenUtil().setSp(50),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('광고 시청수 : 30'),
                  Text('누적 후원금액 : 1,000원'),
                ],
              )
            ],
          ),
        ),
        ListTile(
          title: Text('테스트'),
        )
      ],
    );
  }
}
