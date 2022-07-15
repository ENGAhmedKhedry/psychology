import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:psychology/model/doctor_info_model.dart';
import 'package:psychology/model/patint_info_model.dart';
import 'package:psychology/services/firestore_methods.dart';
import 'package:psychology/utils/my_string.dart';
import 'package:psychology/view/screens/doctor_screens/doctor_chat_screen.dart';
import 'package:psychology/view/screens/doctor_screens/doctor_home_screen.dart';
import 'package:psychology/view/screens/doctor_screens/doctor_profile_screen.dart';
import 'package:psychology/view/screens/patient_screens/blogs_screen.dart';

import '../../../model/diagnosis_model.dart';
import '../../../model/doctor_education_model.dart';
import '../../../model/doctor_exp_model.dart';

class MainDoctorController extends GetxController {
  bool isLoading = false;
  final GetStorage authBox = GetStorage();
  String educationStartDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String educationEndDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(Duration(days: 365 * 4)));

  @override
  void onInit() async {
    await GetStorage.init();
    getMyData();
    super.onInit();
  }

  GetStorage storageBox = GetStorage();
  final myData = Rxn<UserModel>();
  List<Widget> doctorScreens = [
    DoctorHomeScreen(),
    DoctorChatScreen(),
    BlogsScreen(),
    DoctorProfileScreen(),
  ];
  int bottomNavSelectedIndex = 0;

  void bottomTapped(int index) {
    bottomNavSelectedIndex = index;

    update();
  }

  getMyData() async {
    FireStoreMethods()
        .doctors
        .doc(storageBox.read(KUid))
        .snapshots()
        .listen((event) {
      if (event.exists) {
        myData.value = UserModel.fromMap(event);
        update();
      } else {
        print("doctor Data not found0000");
      }
    });
  }

  Future addEducation(
    String education,
    String university,
    String speciality,
    String startDate,
    String endDate,
  ) async {
    isLoading = true;
    update();
    String myUid = authBox.read(KUid);

    DoctorEducationModel doctorEducationModel = DoctorEducationModel(
        doctorId: myUid,
        education: education,
        university: university,
        speciality: speciality,
        startDate: startDate,
        endDate: endDate);
    await FireStoreMethods()
        .doctors
        .doc(myUid)
        .collection(educationCollectionKey)
        .doc()
        .set(doctorEducationModel.toJson(doctorEducationModel))
        .then((value) {
      Get.snackbar("Done", "info added Successfully",
          backgroundColor: Colors.green);

      isLoading = false;

      update();
    }).catchError((onError) {
      Get.snackbar("Error", "$onError", backgroundColor: Colors.red);
      isLoading = false;
      update();
    });
  }

  Future addExperience(
    String experience,
    String industry,
    String startDate,
    String endDate,
  ) async {
    isLoading = true;
    update();
    String myUid = authBox.read(KUid);

    DoctorExperienceModel doctorExperienceModel = DoctorExperienceModel(
        doctorId: myUid,
        experience: experience,
        startDate: startDate,
        endDate: endDate,
        industry: industry);

    await FireStoreMethods()
        .doctors
        .doc(myUid)
        .collection(experienceCollectionKey)
        .doc()
        .set(doctorExperienceModel.toJson(doctorExperienceModel))
        .then((value) {
      isLoading = false;
      update();
      Get.snackbar("Done", "info added Successfully",
          backgroundColor: Colors.green);
    }).catchError((onError) {
      Get.snackbar("Error", "$onError", backgroundColor: Colors.red);
      isLoading = false;
      update();
    });
  }

  changeSelectedStartTime(String dateTime) {
    educationStartDate = dateTime;

    update();
  }

  changeSelectedEndTime(String dateTime) {
    educationEndDate = dateTime;

    update();
  }

  bool isDLoading = false;

  addDiagnosis({required DiagnosisModel diagnosisModel}) async {
    isDLoading = true;
    update();
    await FireStoreMethods()
        .doctors
        .doc(diagnosisModel.doctorId)
        .collection(diagnosisCollectionKey)
        .doc()
        .set(diagnosisModel.toMap(diagnosisModel))
        .then((value) {
      FireStoreMethods()
          .patients
          .doc(diagnosisModel.patientId)
          .collection(diagnosisCollectionKey)
          .doc()
          .set(diagnosisModel.toMap(diagnosisModel))
          .then((value) {
        Get.snackbar("Done", "info added Successfully",
            backgroundColor: Colors.green);
        isDLoading = false;
        update();
      }).catchError((onError) {
        Get.snackbar("Error", "$onError", backgroundColor: Colors.red);
        isDLoading = false;
        update();
      });

      update();
    }).catchError((onError) {
      Get.snackbar("Error", "$onError", backgroundColor: Colors.red);
      isDLoading = false;
      update();
    });
  }
}
