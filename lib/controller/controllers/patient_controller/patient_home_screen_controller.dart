import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:psychology/model/appointment_model.dart';
import 'package:psychology/model/blogs_model.dart';
import 'package:psychology/model/doctor_info_model.dart';
import 'package:psychology/model/patint_info_model.dart';
import 'package:psychology/services/firestore_methods.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/my_string.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/first_tap_bar_column.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/tap_bar_reviews_widget.dart';
import 'package:psychology/view/widgets/utils_widgets/height_size_box.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

import '../../../model/doctor_education_model.dart';
import '../../../model/doctor_exp_model.dart';

class PatientHomeScreenController extends GetxController {
  RxList doctorsList = [].obs;
  RxList doctorExperienceList = [].obs;
  RxList doctorEducationList = [].obs;
  DateTime firstDayDateTime = DateTime(DateTime.now().year,
      DateTime.now().month, DateTime.now().day, 00, 00, 00);
  List<DateTime> daysDateList = [];
  RxList moreDoctorsList = [].obs;
  final patientInfoModel = Rxn<UserModel>();

  RxBool isDeleting = false.obs;
  RxBool isGettingAppointments = false.obs;
  RxList blogsList = [].obs;
  RxList blogsIdList = [].obs;
  var appointmentsList = <AppointmentModel>[].obs;
  List<Widget> tabScreens = [
    FirstTapBarWidget(
      doctorId: '',
    ),
    TabBarReviewsWidget()
  ];
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
    getUserData();
    getMoreDoctorsInfo();
    getDoctorsInfo();
    getBlogs();
    addDaysList();
    super.onInit();
  }

  getDoctorsInfo() async {
    // userStream = await FireStoreMethods().GetUserByUserName(textEditingController.text);
    await FireStoreMethods().doctors.snapshots().listen((event) {
      doctorsList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        doctorsList.add(UserModel.fromMap(event.docs[i]));
      }
    });
    //   update();
  }

  getMoreDoctorsInfo() async {
    await FireStoreMethods().doctors.snapshots().listen((event) {
      moreDoctorsList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        moreDoctorsList.add(UserModel.fromMap(event.docs[i]));
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
      patientInfoModel.value = null;
      if (event.exists) {
        patientInfoModel.value = UserModel.fromMap(event);
      } else {
        Fluttertoast.showToast(
          gravity: ToastGravity.TOP,
          msg: "user data not found in firebase",
          backgroundColor: mainColor2,
        );
      }
      //  update();
    });
  }

  getBlogs() {
    FireStoreMethods()
        .blogs
        .orderBy(
          "date",
        )
        .snapshots()
        .listen((event) {
      blogsList.clear();
      blogsIdList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        blogsList.add(BlogsModel.fromJson(event.docs[i]));
      }
      for (int x = 0; x < event.docs.length; x++) {
        blogsIdList.add(event.docs[x].id);
      }
    });
  }

  daleteBlog({required String id}) {
    isDeleting.value = true;
    FireStoreMethods().blogs.doc(id).delete().then((value) {
      isDeleting.value = false;
      Get.back();
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: "Blog Deleted Successfully",
        backgroundColor: mainColor2,
      );
    }).catchError((onError) {
      isDeleting.value = false;
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: "error: ${onError.toString()}",
        backgroundColor: Colors.red,
      );
    });
  }

  Future getDoctorAppointments({required String doctorId}) async {
    isGettingAppointments.value = true;
    await FireStoreMethods()
        .doctors
        .doc(doctorId)
        .collection(appointmentsCollectionKey)
        .orderBy("appointmentCreationDate", descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        appointmentsList.clear();
        for (int i = 0; i < value.docs.length; i++) {
          appointmentsList.add(AppointmentModel.fromMap(value.docs[i]));
        }
        isGettingAppointments.value = false;
        print("Done");
        update();
      } else {
        isGettingAppointments.value = false;

        appointmentsList.clear();
        print("You don't have appointments");
      }
    });
  }

  Future selectAppointment({
    required String doctorId,
    required String startTime,
    required String endTime,
    required String dayDate,
    required String myId,
    required String myImage,
    required String myName,
    required String myToken,
    required bool isTaken,
  }) async {
    await FireStoreMethods()
        .doctors
        .doc(doctorId)
        .collection(appointmentsCollectionKey)
        .doc("${startTime}-${endTime}-${dayDate}")
        .update({
      "isTaken": isTaken,
      "patientId": myId,
      "patientImage": myImage,
      "patientName": myName,
      "patientToken": myToken,
    }).then((value) async {
      await getDoctorAppointments(doctorId: doctorId);

      Get.defaultDialog(
          titleStyle: TextStyle(fontSize: 0),
          content: Column(
            children: [
              Container(
                  height: Get.width * .5,
                  width: Get.width * .5,
                  child: Lottie.asset(
                    "assets/animations/88860-success-animation.json",
                    fit: BoxFit.cover,
                    repeat: false,
                  )),
              HeightSizeBox(8),
              KTextUtils(
                  text: !isTaken
                      ? "Appointment canceled"
                      : "Appointment Booked Successfully",
                  size: 18,
                  color: !isTaken ? Color(0xffe9b5b3) : mainColor,
                  fontWeight: FontWeight.bold,
                  textDecoration: TextDecoration.none)
            ],
          ));
      update();
    }).catchError((onError) {
      Get.snackbar("error", "$onError");
    });
  }

  addDaysList() {
    daysDateList.clear();
    for (int i = 0; i < 7; i++) {
      daysDateList.add(firstDayDateTime.add(Duration(days: i)));
    }
  }

  /// //////////////////////////////////////////////
  bool isLoading = false;

  getDoctorInfo({
    required String doctorId,
    required String doctorInfoField,
  }) async {
    isLoading = true;
    update();
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
          update();
        } else if (doctorInfoField == educationCollectionKey) {
          doctorEducationList.clear();
          for (int i = 0; i < value.docs.length; i++) {
            doctorEducationList
                .add(DoctorEducationModel.fromJson(value.docs[i]));
          }
          isLoading = false;
          update();
        }
      }
    }).catchError((onError) {
      Get.snackbar("error", "$onError");
      isLoading = false;
      update();
    });
  }

  /// search doctors by name
  RxList searchList = [].obs;
  RxBool isSearching = false.obs;
  TextEditingController search = TextEditingController();

  void addSearchToList(
      String searchName,) {
    if (search.text.isEmpty ) {
      isSearching.value = false;
      searchList.clear();

    } else {
      isSearching.value = true;
    }update();
    searchName = searchName.toLowerCase();
    // searchList.value = productList.where((search) {
    //   var searchTitle = search.title.toLowerCase();
    //   var searchPrice = search.price.toString().toLowerCase();
    //
    //   return searchTitle.contains(searchName) ||
    //       searchPrice.toString().contains(searchName);
    // }).toList();

    searchList.value = doctorsList.value.where((search) {
      return search.displayName!.toLowerCase().contains(searchName);
    }).toList();
    print(searchList.value[0].displayName);

    update();
  }

// void clearSearch() {
//   searchTextController.clear();
//   addSearchToList("");
// }
}
