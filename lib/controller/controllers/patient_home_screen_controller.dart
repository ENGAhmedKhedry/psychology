import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psychology/model/doctor_info_model.dart';
import 'package:psychology/services/firestore_methods.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/first_tap_bar_column.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/tap_bar_reviews_widget.dart';

import '../../model/patint_info_model.dart';
import '../../utils/my_string.dart';

class PatientHomeScreenController extends GetxController {
  RxList doctorsList = [].obs ;
  RxList  moreDoctorsList = [].obs;
  PatientInfoModel? patientInfoModel;

  List<Widget> tabScreens = [FirstTapBarWidget(), TabBarReviewsWidget()];
  List<Color> colorList = [
    Color(0xffFFD93D),
    mainColor2,
    Color(0xffF190B7),
    yelloo,
    Color(0xff97DBAE),
  ];

  GetStorage authBox = GetStorage();

  @override
  void onInit() async {
    // TODO: implement onInit
    await GetStorage.init();
getUserData();getMoreDoctorsInfo();getDoctorsInfo();
    super.onInit();
  }

  getDoctorsInfo() async {
    // userStream = await FireStoreMethods().GetUserByUserName(textEditingController.text);
    await FireStoreMethods().doctors.snapshots().listen((event) {
      doctorsList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        doctorsList.add(DoctorInfo.fromJson(event.docs[i]));
      }
    });
    //   update();
  }

  getMoreDoctorsInfo() async {
    await FireStoreMethods().doctors.snapshots().listen((event) {
      moreDoctorsList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        moreDoctorsList.add(DoctorInfo.fromJson(event.docs[i]));
        debugPrint("${moreDoctorsList[0].displayName} ");
      }
    });
    //  update();
  }

  getUserData() async {
    await FireStoreMethods()
        .patients
        .doc(authBox.read(KUid))
        .snapshots()
        .listen((event) {
      patientInfoModel = null;
      patientInfoModel = PatientInfoModel.fromMap(event);
      debugPrint("${patientInfoModel!.displayName} ");
      //  update();
    });
  }
}
