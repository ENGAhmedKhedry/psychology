import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/patient_home_screen_controller.dart';
import 'package:psychology/model/doctor_info_model.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/doctor_card.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

class MoreTherapistsGridViewWidget extends StatelessWidget {
  MoreTherapistsGridViewWidget({Key? key}) : super(key: key);
  final controller = Get.put(PatientHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: SizeConfig.defaultSize! * 1,
          width: SizeConfig.screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              KTextUtils(
                  text: "More Therapists",
                  size: SizeConfig.defaultSize! * 1.05,
                  color: black,
                  fontWeight: FontWeight.w800,
                  textDecoration: TextDecoration.none),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        GetBuilder<PatientHomeScreenController>(
          builder: (_) {
            return StreamBuilder<QuerySnapshot>(
                stream: controller.doctorsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    controller.doctorsList.clear();

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      controller.doctorsList
                          .add(DoctorInfo.fromJson(snapshot.data!.docs[i]));
                    }
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.doctorsList.length,
                        // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        //     childAspectRatio: 1, maxCrossAxisExtent: 200),
                        itemBuilder: (context, index) {
                          return DoctorCard(
                            imageUrl:
                                controller.doctorsList[index].profileUrl,
                            name: controller.doctorsList[index].displayName,
                            description: controller.doctorsList[index].email,
                            uid: controller.doctorsList[index].uid,
                          );
                        });
                  } else {
                    return Center(
                        child: Container(
                            child: CircularProgressIndicator(
                      color: mainColor,
                    )));
                  }
                });
          },
        )
      ],
    );
  }
}
