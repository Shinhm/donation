import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  String _appId = Platform.isAndroid
      ? 'ca-app-pub-2902183185088647~3849410863'
      : 'ca-app-pub-2902183185088647~2042979950';
  int _coins = 0;
  bool loadedAd;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: _appId);
    this.loadAdVideo();
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
        setState(() {
          _coins += rewardAmount;
        });
      }
    };
  }

  void loadAdVideo() {
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
    print(loadedAd);
    return SafeArea(
      child: GridView.count(
        crossAxisCount: 4,
        children: List.generate(14, (index) {
          return InkWell(
            onTap: () {
              this.showAdVideo();
            },
            child: Center(child: Text('광고 보기')),
          );
        }),
      ),
    );
  }
}
