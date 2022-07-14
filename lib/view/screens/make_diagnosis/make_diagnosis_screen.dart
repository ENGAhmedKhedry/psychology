import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/doctor_controller/doctor_home_controller.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/styles.dart';
import 'package:psychology/view/widgets/utils_widgets/height_size_box.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

import '../call_screens/answer_call/answer_call_wrap_layout.dart';

class MakeDiagnosis extends StatelessWidget {
  TextEditingController diseaseNameController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  // final doctorHomeController = Get.find<DoctorHomeController>();
  // UserModel userModel = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return AnswerCallWrapLayout(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 3,
          actions: [
            GetBuilder(
              builder: (DoctorHomeController doctorHomeController) {
                return TextButton(
                    onPressed: () {
                      if (diseaseNameController.text.isEmpty) {
                        Fluttertoast.showToast(
                          gravity: ToastGravity.TOP,
                          msg: "enter the the disease name",
                          backgroundColor: Colors.red,
                        );
                      } else if (diagnosisController.text.isEmpty) {
                        Fluttertoast.showToast(
                          gravity: ToastGravity.TOP,
                          msg: "enter the diagnosis",
                          backgroundColor: Colors.red,
                        );
                      }
                      // else if (doctorHomeController.blogImage == null) {
                      //   Fluttertoast.showToast(
                      //     gravity: ToastGravity.BOTTOM,
                      //     msg: "Please Add Image",
                      //     backgroundColor: Colors.red,
                      //   );
                      // }
                      else {
                        doctorHomeController.uploadingNewBlog(
                            diagnosisController.text,
                            diseaseNameController.text);
                      }
                    },
                    child: Text(
                      "Send",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ));
              },
            )
          ],
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(IconBroken.Arrow___Left_2,color: black,),
          ),
          backgroundColor: mainColor4,
          title: const Text("Create Diagnosis",style: TextStyle(color: black),),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // GetBuilder(
            //   builder: (DoctorHomeController doctorHomeController) {
            //     return doctorHomeController.isLoading.value
            //         ? LinearProgressIndicator(
            //       color: mainColor2,
            //     )
            //         : SizedBox();
            //   },
            // ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeightSizeBox(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: Get.width * .135,
                            width: Get.width * .135,
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //   image: NetworkImage(
                              //     "$imageUrl",
                              //   ),
                              // ),
                              borderRadius: BorderRadius.circular(Get.width * .2),
                            ),
                            child: Card(
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(Get.width * .2)),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(Get.width * .2),
                                 child:SizedBox()
                                  //////////صورة الدكتور//////////
                                // FadeInImage.assetNetwork(
                                //     fit: BoxFit.cover,
                                //     placeholder:
                                //     "assets/animations/63065-profile-in-out.gif",
                                //     image: userModel.profileUrl!),
                              ),
                            ),
                          ),
                          ////////////اسم الدكتور////////
                          KTextUtils(
                              text: 'userModel.displayName!',
                              size: 18,
                              color: black,
                              fontWeight: FontWeight.w700,
                              textDecoration: TextDecoration.none)
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: Get.height * .06,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: diseaseNameController,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: darkGrey),
                            decoration: InputDecoration(
                              label: Text(
                                "The Disease Name",
                                style: TextStyle(color: Colors.black54),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: darkGrey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: darkGrey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: darkGrey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "write the disease name..",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            cursorColor: Colors.black,
                            cursorHeight: 20,
                            cursorRadius: Radius.circular(20),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: diagnosisController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: darkGrey),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "write diagnosis..",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            cursorColor: Colors.black,
                            cursorHeight: 20,
                            cursorRadius: Radius.circular(20),
                          )),
                      // GetBuilder(
                      //     builder: (DoctorHomeController doctorHomeController) {
                      //       return doctorHomeController.blogImage != null
                      //           ? Stack(
                      //         alignment: AlignmentDirectional.topEnd,
                      //         children: [
                      //           Align(
                      //             alignment: AlignmentDirectional.bottomCenter,
                      //             child: Container(
                      //               width: double.infinity,
                      //               decoration: BoxDecoration(
                      //                 color: Theme.of(context)
                      //                     .scaffoldBackgroundColor,
                      //                 borderRadius: BorderRadius.circular(10),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.4),
                      //                       blurRadius: 9,
                      //                       spreadRadius: 4,
                      //                       offset: Offset(0, 4))
                      //                 ],
                      //               ),
                      //               child: ClipRRect(
                      //                 borderRadius: BorderRadius.circular(10),
                      //                 child: Image(
                      //                     image: FileImage(
                      //                         doctorHomeController.blogImage!),
                      //                     fit: BoxFit.contain),
                      //               ),
                      //             ),
                      //           ),
                      //           IconButton(
                      //               onPressed: () {
                      //                 doctorHomeController.clearImage();
                      //               },
                      //               icon: Container(
                      //                 decoration: BoxDecoration(
                      //                     shape: BoxShape.circle,
                      //                     boxShadow: [
                      //                       BoxShadow(
                      //                           color: Colors.grey
                      //                               .withOpacity(0.4),
                      //                           blurRadius: 9,
                      //                           spreadRadius: 4,
                      //                           offset: Offset(0, 4))
                      //                     ]),
                      //                 child: CircleAvatar(
                      //                     backgroundColor: Theme.of(context)
                      //                         .scaffoldBackgroundColor,
                      //                     child: const Icon(
                      //                       Icons.close_rounded,
                      //                       color: mainColor2,
                      //                     )),
                      //               ))
                      //         ],
                      //       )
                      //           : const SizedBox();
                      //     }),
                      SizedBox(
                        height: Get.height * .1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
