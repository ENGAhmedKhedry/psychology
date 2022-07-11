import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/call_controller.dart';
import 'package:psychology/controller/controllers/patient_controller/main_patient_controller.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/utils/styles.dart';

class PatientMainScreen extends StatelessWidget {
  PatientMainScreen({Key? key}) : super(key: key);

  final controller = Get.find<MainPatientController>();
  PageController pageController = PageController();
  final callController = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<MainPatientController>(
      builder: (_) {
        return Scaffold(
            body: PageView(
              onPageChanged: (val) {
                controller.pageChanged(val);
              },
              controller: controller.pageController,
              allowImplicitScrolling: true,
              scrollDirection: Axis.horizontal,
              children: controller.patientScreens,
            ),
            bottomNavigationBar: Obx(() {
              return callController.isComingCall.value == true
                  ? SizedBox()
                  : BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      backgroundColor: Colors.green,
                      currentIndex: controller.bottomSelectedIndex,
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
            }));
      },
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
