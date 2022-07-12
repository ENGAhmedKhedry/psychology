import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/patient_controller/patient_home_screen_controller.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/home_screen_doctor_container_bocking.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

import '../../../../utils/constants.dart';

class PopularDoctorsListView extends StatelessWidget {
  PopularDoctorsListView({Key? key}) : super(key: key);
  final controller = Get.put(PatientHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              controller.doctorsList.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: SizeConfig.screenHeight! * 0.04,
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KTextUtils(
                              text: "Popular Doctors",
                              size: SizeConfig.defaultSize! * 0.9,
                              color: black,
                              fontWeight: FontWeight.w800,
                              textDecoration: TextDecoration.none),
                          // InkWell(
                          //   onTap: () {},
                          //   child: KTextUtils(
                          //       text: "See More",
                          //       size: 16,
                          //       color: mainColor2,
                          //       fontWeight: FontWeight.w600,
                          //       textDecoration: TextDecoration.none),
                          // )
                        ],
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: controller.doctorsList.isNotEmpty
                    ? SizeConfig.defaultSize! * 7.1
                    : 0,
                child: controller.doctorsList.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return HomeScreenDoctorContainerBocking(
                            imageUrl: controller.doctorsList[index].profileUrl,
                            name: controller.doctorsList[index].displayName,
                            description: controller.doctorsList[index].bio,
                            uid: controller.doctorsList[index].uid,
                            doctorInfo: controller.doctorsList[index],
                          );
                        },
                        itemCount: controller.doctorsList.length,
                      )
                    : Center(
                        child: Container(
                            child: CircularProgressIndicator(
                        color: mainColor,
                      ))),
              ),
            ],
          ),
        );
      },
    );
  }
}
