import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/auth_controller.dart';
import 'package:psychology/controller/controllers/patient_home_screen_controller.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/screens/patient_screens/patient_update_profile.dart';
import 'package:psychology/view/widgets/utils_widgets/height_size_box.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';
import '../../widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/circule_image_avatar.dart';

class PatientProfileScreen extends StatelessWidget {
  PatientProfileScreen({Key? key}) : super(key: key);
  final controller = Get.find<AuthController>();
  final cc = Get.put(
    PatientHomeScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(
              flex: 2,
            ),
            Obx(
              () {
                if (cc.patientInfoModel.value != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CirculeImageAvatar(
                        imageUrl:
                            cc.patientInfoModel.value!.profileUrl.toString(),
                        width: SizeConfig.defaultSize! * 5,
                      ),
                      HeightSizeBox(SizeConfig.defaultSize! * .7),
                      KTextUtils(
                          text: "${cc.patientInfoModel.value!.displayName}",
                          size: 22,
                          color: darkGrey,
                          fontWeight: FontWeight.w700,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(SizeConfig.defaultSize! * .2),
                      KTextUtils(
                          text: "${cc.patientInfoModel.value!.email}",
                          size: 15,
                          color: grey,
                          fontWeight: FontWeight.w500,
                          textDecoration: TextDecoration.none)
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            const Divider(
              thickness: 1,
              indent: 50,
              endIndent: 50,
            ),
            const Spacer(
              flex: 2,
            ),
            GetBuilder<PatientHomeScreenController>(
              builder: (_) {
                return buildTextButtonIcon(
                  backColor: mainColor,
                  onPressed: () {
                    Get.to(() => PatientUpdateProfile(),
                        arguments: [cc.patientInfoModel.value]);
                  },
                  icon: Icons.edit,
                  iconColor: Colors.white,
                  label: '  Edit Profile    ',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                );
              },
            ),
            const SizedBox(height: 20),
            buildTextButtonIcon(
              backColor: mainColor,
              onPressed: () {},
              icon: Icons.messenger_outline_outlined,
              iconColor: Colors.white,
              label: '  Invite a friend   ',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 20),
            buildTextButtonIcon(
              backColor: mainColor,
              onPressed: () {},
              icon: Icons.help,
              iconColor: Colors.white,
              label: '  Help    ',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const Spacer(flex: 1),
            GetBuilder<AuthController>(
              builder: (_) {
                return buildTextButtonIcon(
                    onPressed: () {
                      Get.defaultDialog(
                          onCancel: () {
                            controller.signOutFromApp();
                          },
                          title: "Logout",
                          textConfirm: "No",
                          middleText: "Are you sure to Logout...!",
                          confirmTextColor: Colors.white,
                          textCancel: "Yes",
                          buttonColor: mainColor2,
                          cancelTextColor: mainColor2,
                          backgroundColor: white);
                    },
                    label: "LogOut",
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    backColor: Colors.transparent);
              },
            ),
            // GetBuilder<AuthController>(
            //   builder: (_) {
            //     return TextButton.icon(
            //       onPressed: () {
            //         controller.signOutFromApp();
            //       },
            //       icon: Icon(
            //         Icons.logout,
            //         color: Colors.red,
            //         size: 30,
            //       ),
            //       label: Text(
            //         "LogOut",
            //         style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.black54),
            //       ),
            //     );
            //   },
            // ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );

    //   Center(
    //     child: Column
    //       (mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SizedBox(height: 200,),
    //         Center(
    //           child: GetBuilder<AuthController>(
    //             builder: (_) {
    //               return InkWell(
    //                   onTap: () {
    //                     controller.signOutFromApp();
    //                   },
    //                   child: Text("LogOut"));
    //             },
    //           ),
    //         ),
    //         Center(
    //           child: GetBuilder<PatientHomeScreenController>(
    //             builder: (_) {
    //               return InkWell(
    //                   onTap: () {
    //                      //cc.getDooctorsInfo();
    //                   },
    //                   child: Text("DoctorData"));
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  buildTextButtonIcon({
    required Function()? onPressed,
    required String label,
    required IconData icon,
    Color? iconColor,
    Color? backColor,
    TextStyle? style,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Container(
            width: SizeConfig.defaultSize! * 2.2,
            height: SizeConfig.defaultSize! * 2.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: backColor),
            child: Icon(
              icon,
              color: iconColor,
            )),
        label: Row(
          children: [
            Text(label, style: style),
          ],
        ),
      ),
    );
  }
}
