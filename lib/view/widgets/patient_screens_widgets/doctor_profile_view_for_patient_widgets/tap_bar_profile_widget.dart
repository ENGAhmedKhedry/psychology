import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

import 'package:psychology/controller/controllers/patient_controller/patient_home_screen_controller.dart';

import '../../../../model/doctor_education_model.dart';
import '../../../../model/doctor_exp_model.dart';
import '../../../../services/firestore_methods.dart';
import '../../../../utils/my_string.dart';

class TabBarProfileWidget extends StatefulWidget {
  String field;
  String doctorId;

  @override
  State<TabBarProfileWidget> createState() => _TabBarProfileWidgetState();

  TabBarProfileWidget({
    required this.field,
    required this.doctorId,
  });
}

class _TabBarProfileWidgetState extends State<TabBarProfileWidget> {
  bool isLoading = false;
  List doctorExperienceList = [];
  List doctorEducationList = [];

  Future getDoctorInfo({
    required String doctorId,
    required String doctorInfoField,
  }) async {
    isLoading = true;
    setState(() {});
    await FireStoreMethods()
        .doctors
        .doc(doctorId)
        .collection(doctorInfoField)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (doctorInfoField == experienceCollectionKey) {
          doctorExperienceList.clear();
          for (int i = 0; i < value.docs.length; i++) {
            doctorExperienceList
                .add(DoctorExperienceModel.fromJson(value.docs[i]));
          }
          isLoading = false;
          setState(() {});
        } else if (doctorInfoField == educationCollectionKey) {
          doctorEducationList.clear();
          for (int i = 0; i < value.docs.length; i++) {
            doctorEducationList
                .add(DoctorEducationModel.fromJson(value.docs[i]));
            setState(() {});
          }
          isLoading = false;
        }
        setState(() {});
      } else {
        print("no data");
      }
    }).catchError((onError) {
      Get.snackbar("error", "$onError");
      isLoading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getDoctorInfo(
      doctorId: widget.doctorId,
      doctorInfoField: widget.field,
    ).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KTextUtils(
              text: widget.field,
              size: 22,
              color: black,
              fontWeight: FontWeight.bold,
              textDecoration: TextDecoration.none),
          SizedBox(),
          isLoading &&
                  doctorEducationList.isEmpty &&
                  doctorExperienceList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : widget.field == experienceCollectionKey
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: doctorExperienceList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Row(
                            children: [
                              GetBuilder<PatientHomeScreenController>(
                                builder: (c) {
                                  return Container(
                                    width: SizeConfig.defaultSize! * .8,
                                    height: SizeConfig.defaultSize! * 3,
                                    color: c.colorList[index] == null
                                        ? mainColor2
                                        : c.colorList[index],
                                  );
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KTextUtils(
                                      text:
                                          "${doctorExperienceList[index].experience}",
                                      size: Get.width * .04,
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                      textDecoration: TextDecoration.none),
                                  KTextUtils(
                                      text:
                                          "${doctorExperienceList[index].industry}",
                                      size: Get.width * .03,
                                      color: grey,
                                      fontWeight: FontWeight.w600,
                                      textDecoration: TextDecoration.none),
                                  KTextUtils(
                                      text:
                                          "${doctorExperienceList[index].startDate} to ${doctorExperienceList[index].endDate}",
                                      size: Get.width * .028,
                                      color: yelloo,
                                      fontWeight: FontWeight.w600,
                                      textDecoration: TextDecoration.none),
                                ],
                              )
                            ],
                          ),
                        );
                      })
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: doctorEducationList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Row(
                            children: [
                              GetBuilder<PatientHomeScreenController>(
                                builder: (c) {
                                  return Container(
                                    width: SizeConfig.defaultSize! * .8,
                                    height: SizeConfig.defaultSize! * 3,
                                    color: c.colorList[index] == null
                                        ? mainColor2
                                        : c.colorList[index],
                                  );
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KTextUtils(
                                      text:
                                          "${doctorEducationList[index].education}",
                                      size: Get.width * .04,
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                      textDecoration: TextDecoration.none),
                                  KTextUtils(
                                      text:
                                          "${doctorEducationList[index].university} - ${doctorEducationList[index].speciality}",
                                      size: Get.width * .03,
                                      color: grey,
                                      fontWeight: FontWeight.w600,
                                      textDecoration: TextDecoration.none),
                                  KTextUtils(
                                      text:
                                          "${doctorEducationList[index].startDate} to ${doctorEducationList[index].endDate}",
                                      size: Get.width * .028,
                                      color: yelloo,
                                      fontWeight: FontWeight.w600,
                                      textDecoration: TextDecoration.none),
                                ],
                              )
                            ],
                          ),
                        );
                      })
        ],
      ),
    );
  }
}
