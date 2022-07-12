import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/screens/doctor_screens/doctor_complete_profile/doctor_education_screen.dart';
import 'package:psychology/view/screens/doctor_screens/doctor_complete_profile/doctor_experience_screen.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';

class DoctorDialog extends StatelessWidget {
  const DoctorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor2,
        elevation: 0,
        title: Text("Complete Information"),
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            IconBroken.Arrow___Left_2,
            size: 35,
          ),
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              mainColor2,
              mainColor4,
              mainColor,
              Color(0xffB4ECE3),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2,),
              GestureDetector(
                onTap: () {
                  Get.to(() => DoctorEducation());
                },
                child: Container(
                  height: SizeConfig.defaultSize! * 11,
                  width: SizeConfig.defaultSize! * 11,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        mainColor2,
                        mainColor4,
                        mainColor,
                        Colors.blueAccent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.account_balance_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Education",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => DoctorExperience());
                },
                child: Container(
                  height: SizeConfig.defaultSize! * 11,
                  width: SizeConfig.defaultSize! * 11,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        mainColor2,
                        mainColor4,
                        mainColor,
                        Colors.blue,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.star,
                        size: 70,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Experience",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Spacer(flex:3 ,),

            ],
          ),
        ),
      ),
    );
  }
}
