import 'dart:io';
import 'package:al_madina_taxi/auth/auth_firebase.dart';
import 'package:al_madina_taxi/helper/shared_helper.dart';
import 'package:al_madina_taxi/models/user_model.dart';
import 'package:al_madina_taxi/repositores/firestore_auth_repositories.dart';
import 'package:al_madina_taxi/tracking/realtime.dart';
import 'package:al_madina_taxi/ui/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  String password;
  String userName;
  String email;

  String mobile;
  String uId;

  // FirebaseUser users;
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  loginUsingGmail(BuildContext context) async {
    User users = await FbAuth.auth.loginUsingGmail();

    if (users != null) {
      UserModel userModel = UserModel(
          name: users.displayName,
          email: users.email,
          photoUrl: users.photoURL);

      FirebaseRepositoryAuth.firebaseRepository
          .setUserToFirestore(users, userModel);
      ShaerdHelper.sHelper.setEmail(users.email);
      ShaerdHelper.sHelper.setUserName(users.displayName);
      ShaerdHelper.sHelper.setUid(users.uid);
      ShaerdHelper.sHelper.setPhotoUrl(users.photoURL);

      ShaerdHelper.sHelper.setValueisSeen(true);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => RealtimeMapScrren()));
      print('object');
    }

    notifyListeners();
  }

  Future<String> getUid() async {
    String uid = await ShaerdHelper.sHelper.getUid();
    this.uId = uid;
    notifyListeners();
    return uid;
  }

  Future<List<String>> getInformationUser() async {
    String email = await ShaerdHelper.sHelper.getEmail();
    String photo = await ShaerdHelper.sHelper.getPhotoUrl();
    String name = await ShaerdHelper.sHelper.getUserName();

    List<String> info = [email, photo, name];
    return info;
  }

  Future<User> loginUsingEmailAndPassword(BuildContext context) async {
    User users =
        await FbAuth.auth.loginUsingEmailAndPassword(this.email, this.password);

    if (users != null) {
      UserModel userModel =
          await FirebaseRepositoryAuth.firebaseRepository.getUser(users);

      ShaerdHelper.sHelper.setValueisSeen(true);
      ShaerdHelper.sHelper.setEmail(users.email);
      ShaerdHelper.sHelper.setUserName(userModel.name);
      ShaerdHelper.sHelper.setUid(users.uid);
      ShaerdHelper.sHelper.setPhotoUrl(users.photoURL);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => RealtimeMapScrren()));
    }
    notifyListeners();
    return users;
  }

  signOut() async {
    await FbAuth.auth.signOut();
  }

  saveEmail(String value) {
    this.email = value;
    notifyListeners();
  }

  saveMobile(String value) {
    this.mobile = value;
    notifyListeners();
  }

  saveUserName(String value) {
    this.userName = value;
    notifyListeners();
  }

  savePaswword(String value) {
    this.password = value;
    notifyListeners();
  }

  validatorEmail(String value) {
    if (value == null || value == '') {
      return 'Email is requierd';
    } else if (!isEmail(value)) {
      return 'invaled email syntax';
    }
    notifyListeners();
  }

  validatorUserName(String value) {
    if (value == null || value == '') {
      return 'User name is requierd';
    } else if (!isAlpha(value)) {
      return 'invaled user name syntax';
    }
    notifyListeners();
  }

  validatorPaswword(String value) {
    if (value == null || value == '') {
      return 'Password is requierd';
    } else if (!isAlphanumeric(value)) {
      return 'contains only letters and numbers.';
    }
    notifyListeners();
  }

  validatorMobile(String value) {
    if (value == null || value == '') {
      return 'Mobile is requierd';
    } else if (!isNumeric(value)) {
      return 'contains only number.';
    }
    notifyListeners();
  }

  onSubmitLogin(BuildContext context) async {
    if (formKeyLogin.currentState.validate()) {
      formKeyLogin.currentState.save();

      await loginUsingEmailAndPassword(context);
    } else {
      print('error');
    }
    notifyListeners();
  }

  //================Register==========================
  GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEditProfile = GlobalKey<FormState>();
  File imageFile;
  String url;
  Future<User> registerUsingEmailAndPassword(BuildContext context) async {
    User user = await FbAuth.auth
        .registerUsingEmailAndPassword(this.email, this.password);

    if (user != null) {
      ShaerdHelper.sHelper.setValueisSeen(true);
      UserModel userModel = UserModel(email: user.email, name: this.userName);

      FirebaseRepositoryAuth.firebaseRepository
          .setUserToFirestore(user, userModel);

      ShaerdHelper.sHelper.setEmail(user.email);
      ShaerdHelper.sHelper.setUserName(userName);
      ShaerdHelper.sHelper.setUid(user.uid);
      ShaerdHelper.sHelper.setPhotoUrl(user.photoURL);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => RealtimeMapScrren()));
    }
    // scaffoldKeyLogin.currentState
    //     .showSnackBar(SnackBar(content: Text('Email not found')));
    notifyListeners();
    return user;
  }

  onSubmitRegister(BuildContext context) async {
    if (formKeyRegister.currentState.validate()) {
      formKeyRegister.currentState.save();

      await registerUsingEmailAndPassword(context);
    } else {
      print('error');
    }
    notifyListeners();
  }

  // cameraImage(ImageSource imageSource) async {
  //   PickedFile image =
  //       await ImagePicker().getImage(source: imageSource, imageQuality: 10);

  //   imageFile = await ImageCropper.cropImage(
  //       sourcePath: image.path,
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio4x3,
  //         CropAspectRatioPreset.ratio16x9
  //       ],
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       iosUiSettings: IOSUiSettings(
  //         minimumAspectRatio: 1.0,
  //       ));
  //   // imageFile = File(image.path);

  //   DateTime date = DateTime.now();

  //   StorageTaskSnapshot snapshot = await FirebaseStorage.instance
  //       .ref()
  //       .child('profileImage/$date.jpg')
  //       .putFile(imageFile)
  //       .onComplete;

  //   url = await snapshot.ref.getDownloadURL();
  //   notifyListeners();
  // }

  onSubmitEditProfile(BuildContext context) async {
    if (formKeyEditProfile.currentState.validate()) {
      formKeyEditProfile.currentState.save();
      await getUid();
      ShaerdHelper.sHelper.setEmail(email);
      ShaerdHelper.sHelper.setMobile(mobile);
      ShaerdHelper.sHelper.setUserName(userName);

      // await FirestoreAuth.firestoreAuth.updateUser(
      //     uId,
      //     UserModel(
      //         name: userName, email: email, mobile: mobile, photoUrl: url));
    } else {
      print('error');
    }
    notifyListeners();
  }
}
