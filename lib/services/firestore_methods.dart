import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psychology/model/blogs_model.dart';
import 'package:psychology/utils/my_string.dart';

class FireStoreMethods {
  CollectionReference chatRooms =
      FirebaseFirestore.instance.collection(chatRoomsCollectionKey);
  CollectionReference doctors =
      FirebaseFirestore.instance.collection(doctorsCollectionKey);
  CollectionReference patients =
      FirebaseFirestore.instance.collection(patientsCollectionKey);
  CollectionReference blogs = FirebaseFirestore.instance.collection("blogs");

  Future<void> insertPatientInfoFireStorage(String displayName, email, uid,
      profileUrl, phoneNumber, gender, isDoctor, token) async {
    patients.doc(uid).set({
      'displayName': displayName,
      'uid': uid,
      'email': email,
      "profileUrl": profileUrl,
      "phoneNumber": phoneNumber,
      "gender": gender,
      "registerDate": DateTime.now(),
      "isDoctor": false,
      "identityFile": " ",
      "bio":"null",
      "token": token
    });
    return;
  }

  Future<void> insertDoctorInfoFireStorage(String displayName, email, uid,
      profileUrl, identityFile, phoneNumber, gender, isDoctor, token) async {
    doctors.doc(uid).set({
      'displayName': displayName,
      'uid': uid,
      'email': email,
      "profileUrl": profileUrl,
      "identityFile": identityFile,
      "phoneNumber": phoneNumber,
      "gender": gender,
      "bio":" ",

      "isDoctor": isDoctor,
      "registerDate": DateTime.now(),
      "token": token
    });
    return;
  }

  Future<void> updateDoctorIdentity(uid, identityFilrUrl) {
    return doctors
        .doc(uid)
        .update({'identityFile': identityFilrUrl})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update doctor Image: $error"));
  } /////////////////////////////////

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return chatRooms.doc(chatRoomId).update(lastMessageInfoMap);
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return chatRooms
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

////////////////////////////////////deleteMessage    //////////////////////////////
  Future<void> deleteMessage(
    String chatRoomId,
    String messageId,
  ) async {
    return chatRooms
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .delete();
  }

//////////////////////////////////////////
  Future<void> addBlog({
    required String body,
    required String imageUrl,
    required String title,
    required String blogOwnerId,
    required date,
  }) async {
    await blogs.add({
      'body': body,
      'imageUrl': imageUrl,
      'title': title,
      'blogOwnerId': blogOwnerId,
      'date': date,
    });
  }
}
