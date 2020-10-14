import 'package:al_madina_taxi/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreAuth {
  FirestoreAuth._();

  static FirestoreAuth firestoreAuth = FirestoreAuth._();

  setUserToFirestore(User user, Map<String, dynamic> map) async {
    await FirebaseFirestore.instance.collection('Users').doc(user.uid).set(map);
  }

  updateUser(String uId, UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .update(userModel.toJson());
  }

  // Future<DocumentSnapshot> getUser(String uId) async {
  //   DocumentSnapshot documentSnapshot =
  //       await Firestore.instance.collection('Users').document(uId).get();
  //   return documentSnapshot;
  // }

  Future<DocumentSnapshot> getUser(User user) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    return documentSnapshot;
  }
}
