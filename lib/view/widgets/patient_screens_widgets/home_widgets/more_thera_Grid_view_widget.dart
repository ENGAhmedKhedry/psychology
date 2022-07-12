import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/patient_controller/patient_home_screen_controller.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/doctor_card.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

class MoreTherapistsGridViewWidget extends StatelessWidget {
  MoreTherapistsGridViewWidget({Key? key}) : super(key: key);
  final controller = Get.put(PatientHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.moreDoctorsList.isNotEmpty
            ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: SizeConfig.screenHeight! * 0.04,
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          KTextUtils(
                              text: "More Therapists",
                              size: SizeConfig.defaultSize! * 0.9,
                              color: black,
                              fontWeight: FontWeight.w800,
                              textDecoration: TextDecoration.none),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.doctorsList.length.toInt(),
                        // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        //     childAspectRatio: 1, maxCrossAxisExtent: 200),
                        itemBuilder: (context, index) {
                          return DoctorCard(
                            imageUrl: controller.doctorsList[index].profileUrl,
                            name: controller.doctorsList[index].displayName,
                            description: controller.doctorsList[index].bio,
                            uid: controller.doctorsList[index].uid,
                            doctorInfo: controller.doctorsList[index],
                          );
                        })
                  ],
                ),
            )
            : SizedBox(
                child: Center(
                  child: KTextUtils(
                      text: "Theres no doctors ",
                      size: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.none),
                ),
              );
      },
    );
  }
}
