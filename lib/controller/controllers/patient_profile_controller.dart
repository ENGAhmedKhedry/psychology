import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psychology/view/screens/patient_screens/patient_main_screen.dart';


class PatientProfileController extends GetxController {
  bool isLoading = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  //////////////////////////////
  final ImagePicker picker = ImagePicker();
  File? profileImageFile;

  getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImageFile = File(pickedFile.path);
      update();
    } else {
      print("No Image Selected");
    }
    update();
  }

  clearImage() {
    profileImageFile = null;
    update();
  }

  ///////////////////////////

  updateUserInfo(Map<String, Object> map, uid, collectionKey) {
    isLoading = true;
    update();
    return FirebaseFirestore.instance
        .collection(collectionKey)
        .doc(uid)
        .update(map)
        .then((value) {
      Get.snackbar(
        "Updated ✔✔",
        "Added to firestore successfully",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      isLoading = false;
      update();
       Get.offAll(() => PatientMainScreen());

    }).catchError((error) {
      isLoading = false;
      update();
      Get.snackbar(
        "Error",
        "please add eee$error",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    });
  }

  Future updateUserImageStorage(
    uid,
    imageUrl,
    name,
    phoneNumber,
    email,
    collectionKey,
  ) async{
    isLoading = true;
    update();
    if (profileImageFile != null) {
      storage
          .ref()
          .child(
              "$collectionKey/$uid/${Uri.file(profileImageFile!.path).pathSegments.last}")
          .putFile(profileImageFile!)
          .then((value) {
        value.ref.getDownloadURL().then((value) async{


          updateUserInfo({
            'displayName': name,
            'email': email,
            "profileUrl": value,
            "phoneNumber": phoneNumber,
          }, uid, collectionKey);
           Get.snackbar(
            "Uploaded ✔✔",
            "Uploaded to firestorage successfully",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
          );
        }).catchError((onError) {
          isLoading = false;
          update();
          Get.snackbar(
            "Error",
            "please add eee$onError",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
          print(onError);
        });
      }).catchError((onError) {
        print(onError);
      });
    } else {
      updateUserInfo({
        'displayName': name,
        'email': email,
        "profileUrl": imageUrl,
        "phoneNumber": phoneNumber,
      }, uid, collectionKey);
    }
  }
}
