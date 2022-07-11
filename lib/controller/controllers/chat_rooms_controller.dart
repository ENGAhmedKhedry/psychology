import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psychology/model/chat_room_model.dart';
import 'package:psychology/model/patint_info_model.dart';
import 'package:psychology/services/firestore_methods.dart';
import 'package:psychology/utils/my_string.dart';

class ChatRoomsController extends GetxController {
  GetStorage authBox = GetStorage();
  var myUid;

  var chatRoomsList = <ChatRoomModel>[].obs;

  // final friendInfoModel = Rxn<UserModel>();
  var friendInfoModel = <UserModel>[].obs;

  @override
  void onInit() async {
    await GetStorage.init();
    getAllChatRooms();
    myUid = authBox.read(KUid);
    super.onInit();
  }

  getChatRoomIdByUser(
    String a,
    String b,
  ) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

/////////////////////////////////////////createChatRoom///////////////////////////
  Future createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot = await FireStoreMethods().chatRooms.doc(chatRoomId).get();
    if (snapShot.exists) {
      return true;
    } else {
      return FireStoreMethods().chatRooms.doc(chatRoomId).set(chatRoomInfoMap);
    }
  }

///////////////////////////////////////// getAllChatRooms ///////////////////////////

  getAllChatRooms() async {
    String myUid = await authBox.read(KUid);

    await FireStoreMethods()
        .chatRooms
        .orderBy("lastMessageSendTs", descending: true)
        .where("chatRoomUsers", arrayContains: myUid)
        .snapshots()
        .listen((event) {
      chatRoomsList.clear();
      friendInfoModel.clear();
      for (int i = 0; i < event.docs.length; i++) {
        chatRoomsList.add(ChatRoomModel.fromMap(event.docs[i]));
      }
    });
  }

  ///////////////////////////////////////// Delete my ChatRoom ///////////////////////////
  deleteChatRoom(String chatRoomId) async {
    await FireStoreMethods()
        .chatRooms
        .doc(chatRoomId)
        .collection("chats")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await FireStoreMethods().chatRooms.doc(chatRoomId).delete().then((value) {
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: "Chat Deleted",
        backgroundColor: Colors.red,
      );
    });
  }

  /////////////////////////getFriendDataByUid/////////////////////////

  getFriendDataByUid(ChatRoomId) {
    var myFriendId =
        ChatRoomId.replaceAll(authBox.read(KUid), "").replaceAll("_", "");
    authBox.read("auth") == doctorsCollectionKey
        ? FireStoreMethods()
            .patients
            .doc(myFriendId)
            .snapshots()
            .listen((event) {
            friendInfoModel.add(UserModel.fromMap(event));

            //update();
          })
        : FireStoreMethods()
            .doctors
            .doc(myFriendId)
            .snapshots()
            .listen((event) {
            friendInfoModel.add(UserModel.fromMap(event));
            //update();
          });
  }
  getUserData(uid) async {
    FireStoreMethods()
        .patients
        .doc(uid)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        user.value = UserModel.fromMap(event);
        update();
      } else {
        print("doctor Data not found0000");
      }
    });
  }  final user = Rxn<UserModel>();

}
