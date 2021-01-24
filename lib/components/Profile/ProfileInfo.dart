import 'package:donation/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ProfileInfo extends StatelessWidget {
  final User user;

  ProfileInfo({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.user);
    return Container(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                    child: Text('광고 시청수'),
                  ),
                  user != null
                      ? Text('${user.viewCount}회')
                      : SkeletonAnimation(
                          child: Container(
                            width: 70.0,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                    child: Text('누적 후원금액'),
                  ),
                  user != null
                      ? Text('${user.totalDonationAmount}원')
                      : SkeletonAnimation(
                          child: Container(
                            width: 70.0,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
