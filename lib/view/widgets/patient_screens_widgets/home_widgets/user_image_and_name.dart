import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psychology/controller/controllers/patient_controller/patient_home_screen_controller.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/circule_image_avatar.dart';

import '../../utils_widgets/text_utils.dart';

class UserImageAndName extends StatelessWidget {
  final controller = Get.put(PatientHomeScreenController());
  GetStorage authBox = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Obx(
         () {
           if (controller.patientInfoModel.value == null) {
            return SizedBox(child: LinearProgressIndicator());
          } else {
            return Row(
              children: [
                CirculeImageAvatar(
                  imageUrl: controller.patientInfoModel.value!.profileUrl.toString(),
                  width: SizeConfig.defaultSize! * 4,
                ),
                SizedBox(
                  width: SizeConfig.defaultSize,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KTextUtils(
                        text: "Hello,",
                        size: 18,
                        color: darkGrey,
                        fontWeight: FontWeight.w500,
                        textDecoration: TextDecoration.none),
                    KTextUtils(
                        text:
                            controller.patientInfoModel.value!.displayName.toString(),
                        size: 20,
                        color: black,
                        fontWeight: FontWeight.w600,
                        textDecoration: TextDecoration.none),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
