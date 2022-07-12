import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/call_controller.dart';
import 'package:psychology/controller/controllers/doctor_controller/doctor_main_controller.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/utils/styles.dart';

import 'activate_doctor_account_layout.dart';

class DoctorMainScreen extends StatelessWidget {
  DoctorMainScreen({Key? key}) : super(key: key);
  final controller = Get.find<MainDoctorController>();
  final callController = Get.put(CallController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ActivateDoctorAccountWrap(
      scaffold: GetBuilder<MainDoctorController>(
        builder: (_) {
          return Scaffold(
              body: controller.doctorScreens[controller.bottomNavSelectedIndex],
              bottomNavigationBar: Obx(() {
                return callController.isComingCall.value == true
                    ? SizedBox()
                    : BottomNavigationBar(
                  elevation: 5,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.white,
                  currentIndex: controller.bottomNavSelectedIndex,
                  onTap: (index) {
                    controller.bottomTapped(index);
                  },
                  unselectedItemColor: grey,
                  selectedItemColor: mainColor2,
                  items: [
                    buildBottomNavigationBarItem(IconBroken.Home),
                    buildBottomNavigationBarItem(IconBroken.Message),
                    buildBottomNavigationBarItem(IconBroken.Paper),
                    buildBottomNavigationBarItem(IconBroken.User),
                  ],
                );
              }) );
        },
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(IconData iconData) {
    return BottomNavigationBarItem(
      backgroundColor: homeBackGroundColor,
      label: "",
      icon: Icon(
        iconData,
        size: SizeConfig.defaultSize! * 1.6,
      ),
    );
  }
}
