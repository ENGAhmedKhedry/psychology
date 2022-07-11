import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/doctor_controller/doctor_home_controller.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/view/widgets/auth/auth_button.dart';
import 'package:psychology/view/widgets/utils_widgets/height_size_box.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';
import '../../../utils/size_config.dart';

class AddAppointmentScreen extends StatelessWidget {
  final doctorHomeController = Get.put(DoctorHomeController());
  final TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackGroundColor,
      appBar: AppBar(
        backgroundColor: mainColor2,
        title: const Text("Add Appointment"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GetBuilder(
          builder: (DoctorHomeController doctorHomeController) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HeightSizeBox(Get.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KTextUtils(
                          text: "Appointment Day",
                          size: Get.width * .06,
                          color: darkGrey,
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.underline),
                      InkWell(
                        onTap: () {
                          // DatePicker.showDatePicker(
                          //   context,
                          //   currentTime: doctorHomeController.currentDateTime,
                          //   locale: LocaleType.en,
                          //   maxTime: doctorHomeController.currentDateTime
                          //       .add(Duration(days: 7)),
                          //   minTime: doctorHomeController.currentDateTime,
                          //   onChanged: (date) {
                          //     doctorHomeController.changeSelectedDateTime(date);
                          //   },
                          //   onConfirm: (date) {
                          //     doctorHomeController.changeSelectedDateTime(date);
                          //   },
                          // );
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now()
                                .add(Duration(days: 7)),
                          ).then((value) {
                            //Todo: handle date to string
                            //print(DateFormat.yMMMd().format(value!));
                             doctorHomeController.changeSelectedDateTime(value!);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: grey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(8)),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                          child: KTextUtils(
                              text:
                                  "${doctorHomeController.currentDateTime.day}/${doctorHomeController.currentDateTime.month}",
                              size: Get.width * .06,
                              color: darkGrey,
                              fontWeight: FontWeight.bold,
                              textDecoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                  HeightSizeBox(Get.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KTextUtils(
                          text: "from :",
                          size: Get.width * .06,
                          color: darkGrey,
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.none),
                      InkWell(
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            doctorHomeController.changeSelectedStartTime(
                                value!.format(context).toString());
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: grey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(8)),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                          child: KTextUtils(
                              text: doctorHomeController.from,
                              size: Get.width * .06,
                              color: darkGrey,
                              fontWeight: FontWeight.bold,
                              textDecoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                  HeightSizeBox(Get.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KTextUtils(
                          text: "to :",
                          size: Get.width * .06,
                          color: darkGrey,
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.none),
                      InkWell(
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            doctorHomeController.changeSelectedEndTime(
                                value!.format(context).toString());
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: grey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(8)),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                          child: KTextUtils(
                              text: doctorHomeController.to,
                              size: Get.width * .06,
                              color: darkGrey,
                              fontWeight: FontWeight.bold,
                              textDecoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                  HeightSizeBox(Get.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KTextUtils(
                          text: "price :",
                          size: Get.width * .06,
                          color: darkGrey,
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.none),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: Get.width * .3,
                            height: Get.height * .07,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(.5),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextFormField(
                              //   validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Please enter the price';
                              //   } else if (!RegExp(validationPrice).hasMatch(value)) {
                              //     return 'Please enter valid price';
                              //   }
                              //   return null;
                              // },
                              style: TextStyle(
                                fontSize: Get.width * .06,
                                fontWeight: FontWeight.w900,
                              ),
                              keyboardType: TextInputType.number,
                              cursorColor: darkGrey,
                              textAlign: TextAlign.center,
                              controller: priceController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "0 ",
                                filled: true,
                                hintStyle: TextStyle(
                                  fontSize: Get.width * .06,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          KTextUtils(
                              text: "EGP",
                              size: Get.width * .06,
                              color: darkGrey,
                              fontWeight: FontWeight.bold,
                              textDecoration: TextDecoration.none)
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  AuthButton(
                      onPressed: () {
                        if (priceController.text.isEmpty) {
                          Get.snackbar("price needed", "please enter the price",
                              backgroundColor: Colors.red.shade400,
                              snackPosition: SnackPosition.BOTTOM);
                        }
                        // else if (DateTime.parse(doctorHomeController.from)
                        //     .isAfter(DateTime.parse(doctorHomeController.to))) {
                        //   Get.snackbar("check time", "start date incorrect",
                        //       backgroundColor: Colors.red.shade400,
                        //       snackPosition: SnackPosition.BOTTOM);  }
                        else {
                          doctorHomeController
                              .addAppointment(
                                  dayDate: doctorHomeController.currentDateTime
                                      .toString(),
                                  isTaken: false,
                                  patientName: "",
                                  patientImage: "",
                                  patientId: "",
                                  patientToken: "",
                                  startTime: doctorHomeController.from,
                                  endTime: doctorHomeController.to,
                                  price: priceController.text)
                              .then((value) {
                            doctorHomeController.getSpecificAppointmentsList(
                                doctorHomeController.currentDateTime);
                          });
                        }
                      },
                      text: doctorHomeController.isAddingAppointment
                          ? SizedBox(
                              width: SizeConfig.defaultSize,
                              height: SizeConfig.defaultSize,
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ))
                          : KTextUtils(
                              text: "ADD",
                              size: Get.width * .06,
                              color: mainColor2,
                              fontWeight: FontWeight.bold,
                              textDecoration: TextDecoration.none),
                      width: Get.width * .45),
                  HeightSizeBox(Get.height * .1),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
