import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  final int totalDonationAmount;
  final int viewCount;

  User({this.totalDonationAmount, this.viewCount});

  factory User.fromMap(Map map) {
    return User(
      totalDonationAmount: map['totalDonationAmount'] ?? '',
      viewCount: map['viewCount'] ?? 0,
    );
  }

  factory User.fromFireStore(DocumentSnapshot doc) {
    Map map = doc.data;
    return User(
      totalDonationAmount: map['totalDonationAmount'] ?? '',
      viewCount: map['viewCount'] ?? 0,
    );
  }
}
