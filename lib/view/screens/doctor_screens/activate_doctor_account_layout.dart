import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:psychology/controller/controllers/auth_controller.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

import '../../../controller/controllers/doctor_controller/doctor_main_controller.dart';

class ActivateDoctorAccountWrap extends StatelessWidget {
  final Widget scaffold;
  final mainDoctorController = Get.put(MainDoctorController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return mainDoctorController.myData.value == null ||
              mainDoctorController.myData.value!.isDoctor == false
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: mainColor2,
                title: Text("logout",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      authController.signOutFromApp();
                    },
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KTextUtils(
                        text: "your account is not activated yet",
                        size: 18,
                        color: black,
                        fontWeight: FontWeight.w600,
                        textDecoration: TextDecoration.none),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Lottie.asset(
                        "assets/animations/activate.json",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )),
              ),
            )
          : scaffold;
    });
  }

  ActivateDoctorAccountWrap({
    required this.scaffold,
  });
}
