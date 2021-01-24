import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation/models/User.dart';

class DatabaseProvider {
  final Firestore _db = Firestore.instance;

  Future<void> addUser(String id) async {
    await _db
        .collection('users')
        .document(id)
        .setData({'totalDonationAmount': 0, 'viewCount': 0});
  }

  Future<bool> hasUser(String id) async {
    try {
      var snap = await _db.collection('users').document(id).get();
      return snap.exists;
    } catch (e) {
      print(e);
    }
  }

  Future<User> updateUser(String id, int coin, int viewCount) async {
    var documentSnapshot = _db.collection('users').document(id);
    documentSnapshot.updateData({
      'totalDonationAmount': FieldValue.increment(coin),
      'viewCount': FieldValue.increment(viewCount)
    });
    var snap = await documentSnapshot.get();
    return User.fromMap(snap.data);
  }

  Future<User> getUserIfExist(String id) async {
    try {
      bool hasUser = await this.hasUser(id);
      if (!hasUser) {
        await this.addUser(id);
      }
      var snap = await _db.collection('users').document(id).get();
      return User.fromMap(snap.data);
    } catch (e) {
      print('get User error :: $e');
    }
  }
}
