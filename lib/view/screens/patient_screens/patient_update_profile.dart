import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/controller/controllers/patient_controller/patient_profile_controller.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/auth/auth_button.dart';
import 'package:psychology/view/widgets/auth/auth_text_from_field.dart';
import 'package:psychology/view/widgets/utils_widgets/height_size_box.dart';

import '../../../controller/controllers/auth_controller.dart';
import '../../../model/patint_info_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/my_string.dart';
import '../../widgets/patient_screens_widgets/doctor_profile_view_for_patient_widgets/circule_image_avatar.dart';

class PatientUpdateProfile extends StatelessWidget {
  PatientUpdateProfile({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.put(PatientProfileController());
  final cc = Get.put(AuthController());
  UserModel data = Get.arguments[0];
  final formUpdateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController.text = data.displayName!;
    emailController.text = data.email!;
    phoneController.text = data.phoneNumber!;

    return Scaffold(
      backgroundColor: homeBackGroundColor,
      appBar: AppBar(
        // actions: [
        //   TextButton(
        //       onPressed: () {},
        //       child: Text(
        //         "Done",
        //         style: TextStyle(
        //           fontSize: 15,
        //           fontWeight: FontWeight.bold,
        //           color: homeBackGroundColor,
        //         ),
        //       ))
        // ],
        leading: GetBuilder<PatientProfileController>(
          builder: (_) {
            return IconButton(
              onPressed: () {
                Get.back();
                controller.clearImage();
              },
              icon: Icon(Icons.arrow_back_ios_outlined),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "Update Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        backgroundColor: mainColor2,
        elevation: 0,
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
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Form(
              key: formUpdateKey,
              child: Column(
                children: [
                  HeightSizeBox(SizeConfig.defaultSize!),
                  GetBuilder<PatientProfileController>(
                    builder: (_) {
                      return Stack(
                        children: [
                          CirculeImageAvatar(
                            width: SizeConfig.width! * .28,
                            imageUrl: data.profileUrl!,
                            color: Colors.white,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: white.withOpacity(.8),
                              maxRadius: SizeConfig.defaultSize! * 1,
                              child: IconButton(
                                onPressed: () {
                                  controller.getImage();
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: black,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  HeightSizeBox(SizeConfig.defaultSize!),
                  AuthTextFromField(
                    controller: nameController,
                    obscureText: false,
                    validator: (value) {
                      if (value.length == 0) {
                        return 'Please enter name';
                      } else if (value.toString().length <= 2 ||
                          !RegExp(validationName).hasMatch(value)) {
                        return "Enter valid name";
                      } else {
                        return null;
                      }
                    },
                    hintText: "Full name",
                    textInputType: TextInputType.name,
                    suffixIcon: Text(""),
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: white,
                    ),
                  ),
                  HeightSizeBox(SizeConfig.defaultSize!),
                  AuthTextFromField(
                    controller: bioController,
                    obscureText: false,
                    validator: (value) {
                      if (value.length == 0) {
                        return 'Please enter bio';
                      } else {
                        return null;
                      }
                    },
                    hintText: "bio",
                    textInputType: TextInputType.name,
                    suffixIcon: Text(""),
                    prefixIcon: Icon(
                      Icons.insert_drive_file_outlined,
                      color: white,
                    ),
                  ),
                  HeightSizeBox(SizeConfig.defaultSize!),
                  AuthTextFromField(
                    controller: phoneController,
                    obscureText: false,
                    validator: (value) {
                      if (value.length == 0) {
                        return 'Please enter mobile number';
                      } else if (!RegExp(validationPhone).hasMatch(value)) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                    hintText: "Phone number",
                    textInputType: TextInputType.phone,
                    suffixIcon: Text(""),
                    prefixIcon: Icon(
                      Icons.phone_android,
                      color: white,
                    ),
                  ),
                  HeightSizeBox(SizeConfig.defaultSize!),
                  AuthTextFromField(
                    controller: emailController,
                    obscureText: false,
                    validator: (value) {
                      if (value.length == 0) {
                        return 'Please enter email';
                      } else if (!RegExp(validationEmail).hasMatch(value)) {
                        return "Invalid Email";
                      } else {
                        return null;
                      }
                    },
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: white,
                    ),
                    suffixIcon: Text(""),
                  ),
                  HeightSizeBox(SizeConfig.defaultSize!),
                  HeightSizeBox(SizeConfig.defaultSize! * 2),
                  GetBuilder<PatientProfileController>(
                    builder: (_) {
                      return GetBuilder<AuthController>(
                        builder: (_) {
                          return AuthButton(
                              onPressed: () {
                                if (formUpdateKey.currentState!.validate()) {
                                  //     cc.auth.currentUser!.updateEmail(emailController.text);

                                  controller
                                      .updateUserImageStorage(
                                          data.uid!,
                                          data.profileUrl!,
                                          nameController.text,
                                          phoneController.text,
                                          emailController.text,
                                          Get.arguments[1],
                                          bioController.text,
                                          context)
                                      .then((value) {
                                    cc.updateUserEmail(emailController.text);
                                  });
                                }
                              },
                              text: controller.isLoading == true
                                  ? CircularProgressIndicator()
                                  : Text("Update",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)),
                              width: SizeConfig.width! * .7);
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
