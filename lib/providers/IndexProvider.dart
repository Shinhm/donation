import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation/constants/Constants.dart';
import 'package:firebase_core/firebase_core.dart';

class IndexProvider {
  Future<void> initFireStore() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: 'test',
      options: FirebaseOptions(
        googleAppID: Constants.fireBaseAppId(),
        apiKey: Constants.fireBaseAPIKey(),
        projectID: Constants.fireBaseProjectId(),
      ),
    );
    Firestore(app: app);
  }
}
