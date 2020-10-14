import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // String id;
  String name;
  String photoUrl;
  String email;
  String mobile;

  UserModel({this.email, this.name, this.photoUrl, this.mobile});
  UserModel.formJson(DocumentSnapshot documentSnapshot) {
    this.name = documentSnapshot.data()['name'];
    this.photoUrl = documentSnapshot.data()['photoUrl'];
    this.email = documentSnapshot.data()['email'];
    this.mobile = documentSnapshot.data()['mobile'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': this.id,
      'email': this.email,
      'name': this.name,
      'mobile': this.mobile,
      'photoUrl': this.photoUrl
    };
  }
}
