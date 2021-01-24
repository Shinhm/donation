import 'package:donation/constants/Constants.dart';
import 'package:donation/particles/MyParticle.dart';
import 'package:donation/providers/DatabaseProvider.dart';
import 'package:donation/services/DeviceService.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pimp_my_button/pimp_my_button.dart';
import 'package:get/get.dart';

class AdScreen extends StatefulWidget {
  @override
  _AdScreenState createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['기부', '광고기부'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
  );

  DatabaseProvider db = DatabaseProvider();
  String _appId = Constants.adAppId();
  int _coins = 0;
  int _currentCoin = 0;
  int _viewCount = 0;
  bool loadedAd = false;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: _appId);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event :: $event");
      if (event == RewardedVideoAdEvent.closed) {
        this.loadAdVideo();
      }
      if (event == RewardedVideoAdEvent.loaded) {
        print('광고 로드 :: $loadedAd');
        setState(() {
          loadedAd = true;
        });
      }
      if (event == RewardedVideoAdEvent.rewarded) {
        print('reward type :: $rewardType');
        print('reward coin :: $rewardAmount');
        setState(() {
          _currentCoin = rewardAmount;
          _coins += rewardAmount;
          _viewCount += 1;
        });
        Get.dialog(_showDialog());
      }
    };
  }

  @protected
  @mustCallSuper
  void didChangeDependencies() {
    this.loadAdVideo();
    setState(() {
      loadedAd = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    () async {
      if (_viewCount != 0) {
        DeviceService ds = DeviceService();
        String deviceId = await ds.getId();
        db.updateUser(deviceId, _coins, _viewCount);
      }
    }();
  }

  void loadAdVideo() {
    print('loading...');
    setState(() {
      loadedAd = false;
    });
    RewardedVideoAd.instance.load(
        adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
  }

  void showAdVideo() {
    RewardedVideoAd.instance.show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PimpedButton(
              particle: MyParticle(),
              pimpedWidgetBuilder: (context, controller) {
                print(loadedAd);
                if (loadedAd) {
                  controller.repeat(period: Duration(seconds: 2));
                } else {
                  controller.reset();
                }
                return GestureDetector(
                  onTap: () {
                    showAdVideo();
                  },
                  child: ClipOval(
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      height: ScreenUtil().setWidth(100.0),
                      width: ScreenUtil().setWidth(100.0),
                      child: Center(
                          child: Text(
                        loadedAd ? '리워드 받기' : '로드중...',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _showDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: SizedBox(
        height: ScreenUtil().setHeight(300),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Lottie.asset(
                'assets/lottie/coins.json',
                fit: BoxFit.fill,
                repeat: false,
                height: ScreenUtil().setWidth(200.0),
                width: ScreenUtil().setWidth(200.0),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/lottie/coinpig.json',
                  fit: BoxFit.fill,
                  repeat: false,
                  height: ScreenUtil().setWidth(210.0),
                  width: ScreenUtil().setWidth(210.0)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: ScreenUtil().setWidth(200),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '+$_currentCoin원 적립 완료',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ), //    Center(
      ),
    );
  }
}
