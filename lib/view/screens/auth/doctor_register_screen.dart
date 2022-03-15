import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/utils/my_string.dart';

import 'package:psychology/view/widgets/auth/auth_button.dart';
import 'package:psychology/view/widgets/auth/auth_text_from_field.dart';
import 'package:psychology/view/widgets/auth/upload_file_doctor.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

import '../../../controller/controllers/auth_controller.dart';
import '../../widgets/auth/gender_widget.dart';
import '../../widgets/auth/profile_image_picking.dart';
import '../../widgets/utils_widgets/icon_botton_utils.dart';

class DoctorRegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DoctorRegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/background.jpg",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .03,
              ),
              // الايكون back
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  KIconButtom(
                      icon: Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                      function: () {
                        Get.back();
                      })
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              // الصورة
              ProfileImagePicking(),
              SizedBox(
                height: height * .015,
              ),
              //النص
              Padding(
                padding: const EdgeInsets.only(right: 130),
                child: KTextUtils(
                  text: "Register",
                  size: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  textDecoration: TextDecoration.none,
                ),
              ),
              Divider(
                color: Color(0xff4b455d),
                height: 10,
                endIndent: 70,
                indent: 55,
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              // full name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
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
                        hintText: 'Full Name',
                        textInputType: TextInputType.text,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      //Phone number
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
                        hintText: 'Phone number',
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Email address
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return AuthTextFromField(
                            controller: emailController,
                            obscureText: false,
                            validator: (value) {
                              if (value.length == 0) {
                                return 'Please enter email';
                              } else if (!RegExp(validationEmail)
                                  .hasMatch(value)) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            hintText: 'Email',
                            textInputType: TextInputType.emailAddress,
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //password
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return AuthTextFromField(
                            controller: passwordController,
                            obscureText: false,
                            validator: (value) {
                              if (value.toString().length < 6) {
                                return "Password is too short";
                              } else {
                                return null;
                              }
                            },
                            hintText: 'Password',
                            textInputType: TextInputType.visiblePassword,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GenderWidget(),
                          GetBuilder<AuthController>(
                            builder: (_) {
                              return UploadFileDoctor(
                                onPressed: () {
                                  controller.getIdentityImage();
                                 },
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return AuthButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String name = nameController.text;

                                  String email = emailController.text.trim();
                                  String password = passwordController.text;
                                  String phoneNumber = phoneController.text;

                                  controller.doctorSignUpUsingFirebase(
                                    name: name,
                                    email: email,
                                    password: password,
                                    phoneNumber: phoneNumber,
                                  );
                                }
                              },
                              text: "Sign Up",
                              width: width * .5);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
