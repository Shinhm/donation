import 'dart:io' show Platform;

class Constants {
  static String adAppId() {
    return Platform.isAndroid
        ? 'ca-app-pub-2902183185088647~3849410863'
        : 'ca-app-pub-2902183185088647~2042979950';
  }

  static String fireBaseAppId() {
    return Platform.isAndroid
        ? '1:661293114707:android:1a25c806044450a7a06da6'
        : '1:661293114707:ios:35d0f41f3ef98064a06da6';
  }

  static String fireBaseAPIKey() {
    return 'AIzaSyATbCPHuCc_B02SIbaY9UmcDwgZ-CQUJwE';
  }

  static String fireBaseProjectId() {
    return 'donation-7f0af';
  }
}
