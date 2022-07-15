import 'dart:async';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psychology/controller/controllers/call_controller.dart';
import 'package:psychology/model/call_model.dart';
import 'package:psychology/services/call_methods.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/my_string.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/circule_image_avatar.dart';

import '../make_diagnosis/make_diagnosis_screen.dart';

class VideoCallScreen extends StatefulWidget {
  final Call call;

  VideoCallScreen({
    required this.call,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final callController = Get.put(CallController());
  StreamSubscription? callStreamSubscription;
  RtcEngine? _engine;
  final users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  ClientRole _role = ClientRole.Broadcaster;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
    addPostFrameCallback();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add("APP_ID missing,please provide your app Id");
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    //! initAgoraRtcEnging
    RtcEngineContext context = RtcEngineContext(APP_ID);
    _engine = await RtcEngine.createWithContext(context);

    await RtcEngine.create(APP_ID);

    await _engine!.enableVideo();
    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine!.setClientRole(_role);
//! _addAgoraEventHandlers

    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();

    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine!.setVideoEncoderConfiguration(configuration);

    await _engine!
        .joinChannel(null, callController.comingCall.value!.channelId, null, 0);
  }

  void _addAgoraEventHandlers() {
    _engine!.setEventHandler(
      RtcEngineEventHandler(error: (code) {
        setState(() {
          final info = 'Error: $code';
          _infoStrings.add(info);
        });
      }, joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = 'Join Channel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      }, leaveChannel: (state) {
        setState(() {
          _infoStrings.add("Leave Channel");
          users.clear();
          CallMethods().endCall(call: callController.comingCall.value!);
        });
      }, userJoined: (uid, elapsed) {
        setState(() {
          final info = 'User Joined: $uid';
          _infoStrings.add(info);
          users.add(uid);
        });
      }, userOffline: (uid, elapsed) {
        setState(() {
          final info = 'User Offline: $uid';
          _infoStrings.add(info);
          users.remove(uid);
          CallMethods().endCall(call: callController.comingCall.value!);
        });
      }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = 'First Remote Video: $uid ${width}x $height';
          _infoStrings.add(info);
        });
      }),
    );
  }

  Widget _viewRows() {
    final List<StatefulWidget> list = [];
    if (_role == ClientRole.Broadcaster) {
      list.add(const rtc_local_view.SurfaceView());
    }
    for (var uid in users) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: callController.comingCall.value!.channelId,
      ));
    }
    final views = list;
    return Column(
      children: List.generate(
        views.length,
        (index) => Expanded(
          child: views[index],
        ), // Expanded
      ), // List.generate
    );
    // return Stack(
    //   children: [
    //     Expanded(child: views[0]),
    //     views.length > 1
    //         ? Positioned(
    //             right: Get.width * .1,
    //             top: Get.width * .1,
    //             child: SizedBox(
    //               width: Get.width * .3,
    //               height: Get.height * .3,
    //               child: views[1],
    //             ),
    //           )
    //         : SizedBox()
    //   ],
    // );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              _engine!.muteLocalAudioStream(muted);
            },
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? white : mainColor2,
              size: 20.0,
            ),
            // Icon
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? mainColor2 : white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () async {
              await CallMethods()
                  .endCall(call: callController.comingCall.value!)
                  .then((value) {
                Navigator.pop(context);
              });
            },
            child: const Icon(
              Icons.call_end,
              color: white,
              size: 35.0,
            ),
            // Icon
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine!.switchCamera();
            },
            child: const Icon(
              Icons.switch_camera,
              color: mainColor2,
              size: 20.0,
            ),
            // Icon
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ), // Row
    );
  }

  String isDoctor = GetStorage().read("auth") ?? "";

  addPostFrameCallback() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      callStreamSubscription = callController.callCollection
          .doc(callController.authBox.read(KUid))
          .snapshots()
          .listen((ds) {
        // defining the logic
        switch (ds.exists) {
          case false:
            // snapshot is null which means that call is hanged and documents are deleted
            Navigator.pop(context);
            // if (isDoctor == doctorsCollectionKey) {
            //   Get.defaultDialog(
            //       onConfirm: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => MakeDiagnosis(call: widget.call,)));
            //        // Get.to(MakeDiagnosis());
            //       },
            //       // onCancel: () {
            //       //   Get.back();
            //       // },
            //       title: "Make Diagnosis",
            //       textConfirm: "yes",
            //       middleText:
            //           "Add the diagnosis and medication to the patient's condition",
            //       confirmTextColor: Colors.white,
            //       textCancel: "no",
            //       buttonColor: mainColor2,
            //       cancelTextColor: mainColor2,
            //       backgroundColor: white);
            // }
            break;

          default:
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    users.clear();

    _engine!.leaveChannel();
    _engine!.destroy();
    callStreamSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Stack(children: [
          _viewRows(),
          _toolbar(),
          users.length == 0 && widget.call.callerId == callController.myUid
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CirculeImageAvatar(
                        color: homeBackGroundColor,
                        imageUrl: widget.call.receiverPic,
                        width: Get.width * .3,
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Text(
                        widget.call.receiverName,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: Get.width * .08,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Calling...",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: Get.width * .04,
                        ),
                      ),
                      Spacer(),
                      // Card(
                      //   elevation: 4,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(50)),
                      //   child: InkWell(
                      //     onTap: () async {
                      //       CallMethods().endCall(call: widget.call);
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: Transform.rotate(
                      //         angle: 3,
                      //         child: Icon(
                      //           IconBroken.Call,
                      //           size: Get.width * .12,
                      //           color: Colors.redAccent,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )
              : SizedBox()
        ]),
      ),

      // backgroundColor: darkGrey,
      // body: Container(
      //   alignment: Alignment.center,
      //   padding: EdgeInsets.symmetric(vertical: 100),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       CirculeImageAvatar(
      //         color: homeBackGroundColor,
      //         imageUrl: widget.call.receiverPic,
      //         width: Get.width * .3,
      //         openImageViewer: false,
      //       ),
      //       SizedBox(
      //         height: Get.height * .01,
      //       ),
      //       Text(
      //         widget.call.receiverName,
      //         style: TextStyle(
      //             color: Colors.white70,
      //             fontSize: Get.width * .08,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       Text(
      //         "Calling...",
      //         style: TextStyle(
      //           color: Colors.white54,
      //           fontSize: Get.width * .04,
      //         ),
      //       ),
      //       Spacer(),
      //       Card(
      //         elevation: 4,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(50)),
      //         child: InkWell(
      //           onTap: () async {
      //             CallMethods().endCall(call: widget.call);
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.all(10.0),
      //             child: Transform.rotate(
      //               angle: 3,
      //               child: Icon(
      //                 IconBroken.Call,
      //                 size: Get.width * .12,
      //                 color: Colors.redAccent,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
