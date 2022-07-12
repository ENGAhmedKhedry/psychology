import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? displayName;
  String? email;
  String? profileUrl;
  String? phoneNumber;
  String? gender;
  String? identityFile;
  String? bio;
  Timestamp? registerDate;
  bool? isDoctor;
  String? uid;
  String? token;

  UserModel(
      this.displayName,
      this.uid,
      this.email,
      this.profileUrl,
      this.phoneNumber,
      this.gender,
      this.isDoctor,
      this.identityFile,this.bio,
      this.registerDate,
      this.token);

  factory UserModel.fromMap(map) {
    return UserModel(
      map['displayName'],
      map['uid'],
      map['email'],
      map['profileUrl'],
      map['phoneNumber'],
      map['gender'],
      map['isDoctor'],

      map['identityFile'],
      map['bio'],   map['registerDate'],
      map['token'],
    );
  }
}
