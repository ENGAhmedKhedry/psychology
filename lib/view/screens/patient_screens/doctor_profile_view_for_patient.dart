import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/chat_rooms_controller.dart';
import 'package:psychology/model/patint_info_model.dart';
import 'package:psychology/routes/routes.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/utils/styles.dart';
import 'package:psychology/view/screens/call_screens/answer_call/answer_call_wrap_layout.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/circule_image_avatar.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/nested_appointments_List.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/reviews_and_sissions_widget.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/tabs_widgets.dart';
import 'package:psychology/view/widgets/utils_widgets/height_size_box.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

import '../../../controller/controllers/patient_controller/patient_home_screen_controller.dart';
import '../../widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/first_tap_bar_column.dart';

class DoctorProfileViewForPatient extends StatelessWidget {
  DoctorProfileViewForPatient({Key? key}) : super(key: key);
  String uid = Get.arguments[0];
  String imageUrl = Get.arguments[1];
  String name = Get.arguments[2];
  String description = Get.arguments[3];
  UserModel doctorInfo = Get.arguments[4];
  final controller = Get.find<PatientHomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return AnswerCallWrapLayout(
      scaffold: Scaffold(
        backgroundColor: homeBackGroundColor,
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Container(
                        decoration: buildBoxDecoration(),
                        child: Column(
                          children: [
                            HeightSizeBox(Get.width * .03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.topLeft,
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(
                                          IconBroken.Arrow___Left_2,
                                          color: black,
                                          size: Get.width * .089,
                                        )),
                                  ],
                                ),
                                // SizedBox(
                                //   width: Get.width * .23,
                                // ),
                                Container(
                                    height: Get.width * .25,
                                    width: Get.width * .25,
                                    child: CirculeImageAvatar(
                                      imageUrl: imageUrl,
                                      width: SizeConfig.defaultSize! * 4,
                                    )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GetBuilder(
                                      builder: (ChatRoomsController
                                          chatRoomController) {
                                        return IconButton(
                                            padding: EdgeInsets.zero,
                                            alignment: Alignment.topLeft,
                                            onPressed: () async {
                                              String cattRoomId =
                                                  await chatRoomController
                                                      .getChatRoomIdByUser(
                                                          chatRoomController
                                                              .myUid,
                                                          uid);
                                              chatRoomController
                                                  .createChatRoom(cattRoomId, {
                                                "chatRoomId": cattRoomId,
                                                "chatRoomUsers": [
                                                  doctorInfo.uid!,
                                                  chatRoomController.myUid
                                                ],
                                                "lastMessageSendTs":
                                                    DateTime.now(),
                                                'lastMessage': ' ',
                                                'lastMessageSenderUid':
                                                    chatRoomController.myUid,
                                              }).then((value) {
                                                Get.toNamed(Routes.chatScreen,
                                                    arguments: [
                                                      doctorInfo,
                                                      cattRoomId,
                                                      chatRoomController.myUid,
                                                      controller
                                                          .patientInfoModel
                                                          .value,
                                                    ]);
                                              });
                                            },
                                            icon: Icon(
                                              IconBroken.Chat,
                                              color: black,
                                              size: Get.width * .07,
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            HeightSizeBox(Get.width * .01),
                            KTextUtils(
                                text: "Dr." + name,
                                size: 21,
                                color: black,
                                fontWeight: FontWeight.w800,
                                textDecoration: TextDecoration.none),
                            HeightSizeBox(Get.width * .01),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                doctorInfo.bio!,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: grey,
                                  fontWeight: FontWeight.w500,
                                ),textAlign: TextAlign.center,
                              ),
                            ),
                            HeightSizeBox(Get.height * .004),
                            ReviewsAndSissions(),
                            HeightSizeBox(Get.height * .015),
                            //     Tabs()
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: GetBuilder<PatientHomeScreenController>(
                builder: (_) {
                  return FirstTapBarWidget(
                    doctorId: doctorInfo.uid!,
                  );
                  // TabBarView(children: controller.tabScreens);
                },
              ),
            ),
          ),
        ),
        floatingActionButton: Obx(() {
          return GestureDetector(
            onTap: () {
              controller.getDoctorAppointments(doctorId: uid).then((value) {
                controller.addDaysList();
                if (controller.appointmentsList.isNotEmpty) {
                  Get.toNamed(Routes.bookingDetailsScreen, arguments: [uid]);
                } else {
                  Get.snackbar("no appointments",
                      "there's no appointment exists for this doctor",
                      backgroundColor: Color(0xffe9b5b3));
                }
              }).catchError((onError) {
                Get.snackbar("error", onError.toString());
              });
            },
            child: Container(
              height: Get.height * .06,
              width: Get.width * .6,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: mainColor2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: controller.isGettingAppointments.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * .1,
                          vertical: Get.height * .028),
                      child: const LinearProgressIndicator(
                        color: white,
                      ),
                    )
                  : const Center(
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                            fontSize: 22,
                            color: white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
            ),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 6,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      color: white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }
}
