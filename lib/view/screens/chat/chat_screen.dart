import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:psychology/controller/controllers/messages_controller.dart';
import 'package:psychology/model/diagnosis_model.dart';
import 'package:psychology/model/patint_info_model.dart';
import 'package:psychology/services/fcm_api_handler.dart';
import 'package:psychology/services/permission_services.dart';
import 'package:psychology/services/call_services.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/view/screens/call_screens/answer_call/answer_call_wrap_layout.dart';
import 'package:psychology/view/screens/make_diagnosis/make_diagnosis_screen.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/chat_widget/chat_buble.dart';
import '../../../../utils/styles.dart';
import '../../../utils/my_string.dart';

class ChatScreen extends StatelessWidget {
  UserModel friendData = Get.arguments[0];
  String chatRoomId = Get.arguments[1];

  String myUid = Get.arguments[2];
  UserModel myData = Get.arguments[3];

  final messagesController = Get.find<MessagesController>();
  String isDoctor = GetStorage().read("auth") ?? "";

  TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnswerCallWrapLayout(
      scaffold: Scaffold(
        backgroundColor: homeBackGroundColor,
        appBar: AppBar(
          actions: [
            isDoctor == doctorsCollectionKey
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MakeDiagnosis(
                                    diagnosisModel: DiagnosisModel(
                                        patientName: friendData.displayName!,
                                        patientId: friendData.uid!,
                                        patientImage: friendData.profileUrl!,
                                        doctorId: myData.uid!,
                                        doctorName: myData.displayName!,
                                        doctorImage: myData.profileUrl!,
                                        diseaseName: "",
                                        diagnosis: "",
                                        Date: "",
                                        treatment: ""),
                                  )));
                    },
                    icon: Icon(
                      IconBroken.Paper_Plus,
                      color: Colors.black,
                    ))
                : SizedBox(),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await Permissions.cameraAndMicrophonePermissionsGranted()
                      ? CallUtils.dial(
                          from: myData,
                          to: friendData,
                          context: context,
                          isAudioCall: true,
                        )
                      : {};
                },
                icon: Icon(
                  IconBroken.Call,
                  color: Colors.black,
                )),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await Permissions.cameraAndMicrophonePermissionsGranted()
                      ? CallUtils.dial(
                          from: myData,
                          to: friendData,
                          context: context,
                          isAudioCall: false,
                        )
                      : {};
                },
                icon: Icon(
                  IconBroken.Video,
                  color: Colors.black,
                )),
          ],
          leading: SizedBox(
            width: 0,
          ),
          leadingWidth: 0,
          backgroundColor: homeBackGroundColor,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                child: Icon(
                  IconBroken.Arrow___Left_2,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.transparent,
                height: Get.width * .1,
                width: Get.width * .1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/l.gif",
                        image: "${friendData.profileUrl}")),
              ),
              SizedBox(
                width: 5,
              ),
              (friendData.displayName.toString()).contains(" ") == false
                  ? Text(
                      "${(friendData.displayName.toString())}",
                      //  "${friendData.displayName}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: black),
                    )
                  : Text(
                      "${(friendData.displayName.toString()).substring(
                        0,
                        (friendData.displayName.toString()).indexOf(" "),
                      )}", //  "${friendData.displayName}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: black),
                    ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: GetX(
                initState: messagesController.getMessages(chatRoomId),
                init: MessagesController(),
                builder: (MessagesController messagesController) {
                  return ListView.builder(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: messagesController.messagesList.length,
                      itemBuilder: (context, index) {
                        bool isAudio = messagesController
                                .messagesList[index].message
                                .contains("audio%2")
                            ? true
                            : false;
                        bool isMe =
                            messagesController.messagesList[index].senderId ==
                                    myUid
                                ? true
                                : false;
                        bool isImage = messagesController
                                .messagesList[index].message
                                .toString()
                                .contains("image%2")
                            ? true
                            : false;
                        bool isVideo = messagesController
                                .messagesList[index].message
                                .contains("video%2")
                            ? true
                            : false;

                        return GestureDetector(
                          onLongPress: () {
                            if (messagesController
                                    .messagesList[index].senderId ==
                                myUid) {
                              Get.defaultDialog(
                                  title: "Delete !!",
                                  confirmTextColor: Colors.white,
                                  content: Text(""),
                                  onCancel: () {},
                                  onConfirm: () async {
                                    await messagesController.deleteMessage(
                                        chatRoomId,
                                        {
                                          "lastMessage": " ",
                                          "lastMessageSenderUid":
                                              messagesController
                                                  .messagesList[index].senderId
                                        },
                                        messagesController
                                            .messagesList[index].messageId);
                                    Get.back();
                                  },
                                  textCancel: "Cancel",
                                  textConfirm: "Delete");
                            }
                          },
                          child: ChatBuble(
                            isMe: isMe,
                            isVideo: isVideo,
                            isImage: isImage,
                            isAudio: isAudio,
                            message:
                                messagesController.messagesList[index].message,
                          ),
                        );
                      });
                },
              )),
              Obx(() {
                return messagesController.isSending.value
                    ? Container(
                        child: LinearProgressIndicator(
                            color: mainColor2, minHeight: 2),
                      )
                    : SizedBox();
              }),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: homeBackGroundColor,
                ),
                height: Get.height * .07,
                child: Obx(
                  () {
                    return Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                margin: EdgeInsets.only(left: 0, bottom: 2),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.5),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )),
                                child: messagesController.recorder.isRecording
                                    ? Container(
                                        alignment: Alignment.bottomCenter,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  messagesController
                                                      .deleteRecord();
                                                },
                                                icon: Icon(IconBroken.Delete)),
                                            StreamBuilder<RecordingDisposition>(
                                              stream: messagesController
                                                  .recorder.onProgress,
                                              builder: (context, snapshot) {
                                                final duration = snapshot
                                                        .hasData
                                                    ? snapshot.data!.duration
                                                    : Duration.zero;

                                                String twoDigits(int n) => n
                                                    .toString()
                                                    .padLeft(2, "0");
                                                final twoDigitMinutes =
                                                    twoDigits(duration.inMinutes
                                                        .remainder(60));
                                                final twoDigitSeconds =
                                                    twoDigits(duration.inSeconds
                                                        .remainder(60));

                                                return Text(
                                                  "$twoDigitMinutes:$twoDigitSeconds",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                );
                                              },
                                            ),
                                            // IconButton(
                                            //     padding: EdgeInsets.zero,
                                            //     onPressed: () {messagesController.stopRecording();},
                                            //     icon: Icon(
                                            //       Icons.stop_rounded,
                                            //       size: Get.width * .085,
                                            //     ))
                                          ],
                                        ))
                                    : TextField(
                                        onChanged: (value) {
                                          messagesController
                                              .isWritingFun(value);
                                        },
                                        controller: messageTextController,
                                        cursorColor: Color(0xFF000000),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            suffixIcon: Transform.rotate(
                                                angle: 1,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Get.defaultDialog(
                                                        title: "Pick !!",
                                                        confirmTextColor:
                                                            Colors.white,
                                                        content: Text(""),
                                                        onCancel: () async {
                                                          await messagesController
                                                              .getImage(
                                                            chatRoomId,
                                                            true,
                                                            myData.uid,
                                                            myData.displayName,
                                                          )
                                                              .then(
                                                                  (value) async {
                                                            FcmHandler.sendMessageNotification(
                                                                friendData
                                                                    .token!,
                                                                "Image",
                                                                myData
                                                                    .displayName,
                                                                myData
                                                                    .profileUrl);
                                                          }).catchError(
                                                                  (onError) {
                                                            debugPrint(
                                                                "lllllllllllllll$onError");
                                                          });
                                                        },
                                                        onConfirm: () async {
                                                          await messagesController
                                                              .getVideo(
                                                            chatRoomId,
                                                            true,
                                                            myData.uid,
                                                            myData.displayName,
                                                          )
                                                              .then((value) {
                                                            FcmHandler.sendMessageNotification(
                                                                friendData
                                                                    .token!,
                                                                "Video",
                                                                myData
                                                                    .displayName,
                                                                myData
                                                                    .profileUrl);
                                                          });
                                                        },
                                                        textCancel: "Image",
                                                        textConfirm: "Video");
                                                  },
                                                  icon: Icon(
                                                    Icons.attach_file_rounded,
                                                    size: 29,
                                                  ),
                                                )),
                                            hintText: "type a message..",
                                            border: InputBorder.none),
                                      ))),
                        !messagesController.isWriting.value
                            ? messagesController.isRecording.value
                                ? IconButton(
                                    onPressed: () async {
                                      await messagesController.initRecorder();
                                      messagesController
                                          .sendRecord(
                                        chatRoomId,
                                        true,
                                        myData.uid,
                                        myData.displayName,
                                      )
                                          .then((value) {
                                        FcmHandler.sendMessageNotification(
                                            friendData.token!,
                                            "voice Record",
                                            myData.displayName,
                                            myData.profileUrl);
                                      });
                                    },
                                    icon: Icon(
                                      IconBroken.Send,
                                      color: Colors.blue,
                                      size: 30,
                                    ))
                                : InkWell(
                                    onTap: () {
                                      //  messagesController.record();
                                    },
                                    child: IconButton(
                                        onPressed: () async {
                                          await messagesController
                                              .initRecorder();
                                          messagesController
                                              .record()
                                              .then((value) {});
                                        },
                                        icon: Icon(
                                          IconBroken.Voice,
                                          color: Colors.blue,
                                          size: 30,
                                        )),
                                  )
                            : Transform.rotate(
                                angle: 88,
                                child: IconButton(
                                    onPressed: () async {
                                      await messagesController.sendMessage(
                                          messageTextController:
                                              messageTextController,
                                          sendClicked: true,
                                          chatRoomId: chatRoomId,
                                          senderName: myData.displayName,
                                          myUserId: myData.uid,
                                          friendToken: friendData.token!,
                                          senderImage: myData.profileUrl);
                                    },
                                    icon: Icon(
                                      IconBroken.Send,
                                      color: Colors.blue,
                                      size: 30,
                                    ))),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
