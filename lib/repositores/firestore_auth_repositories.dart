import 'package:al_madina_taxi/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_auth_client.dart';

class FirebaseRepositoryAuth {
  FirebaseRepositoryAuth._();

  static FirebaseRepositoryAuth firebaseRepository = FirebaseRepositoryAuth._();

  setUserToFirestore(User user, UserModel userModel) async {
    await FirestoreAuth.firestoreAuth
        .setUserToFirestore(user, userModel.toJson());
  }

  Future<UserModel> getUser(User user) async {
    DocumentSnapshot documentSnapshot =
        await FirestoreAuth.firestoreAuth.getUser(user);
    UserModel listQuerySnapshot = UserModel.formJson(documentSnapshot);

    return listQuerySnapshot;
  }
}
