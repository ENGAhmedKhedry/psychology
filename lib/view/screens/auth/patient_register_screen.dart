 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/routes/routes.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/my_string.dart';
import 'package:psychology/view/widgets/auth/auth_button.dart';
import 'package:psychology/view/widgets/auth/auth_text_from_field.dart';
import 'package:psychology/view/widgets/auth/gender_widget.dart';
import 'package:psychology/view/widgets/auth/google_auth_widget.dart';
import '../../../controller/controllers/auth_controller.dart';
import '../../widgets/icon_botton_utils.dart';
import '../../widgets/text_utils.dart';

class PatientRegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  PatientRegisterScreen({Key? key}) : super(key: key);

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
                height: height * .02,
              ),
              // الصورة
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: width * .25,
                    width: width * .25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/profile.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
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
                        hintText: "User Name",
                        textInputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //Phone number
                      AuthTextFromField(
                        controller: phoneController,
                        obscureText: false,
                        validator: (value) {
                          // if (value.length == 0) {
                          //   return 'Please enter mobile number';
                          // } else if (!RegExp(validationPhone).hasMatch(value)) {
                          //   return 'Please enter valid mobile number';
                          // }
                          // return null;
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
                        height: 10,
                      ),
                      GenderWidget(),
                      SizedBox(
                        height: 25,
                      ),
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return AuthButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String name = nameController.text;

                                  String email = emailController.text.trim();
                                  String password = passwordController.text;
                                  controller.signUpUsingFirebase(
                                      name: name,
                                      email: email,
                                      password: password,
                                      );
                                }
                              },
                              text: "Sign Up",
                              width: width * .5);
                        },
                      ),

                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                        children: const [
                          Expanded(
                              child: Divider(
                            color: Colors.black54,
                            endIndent: 5,
                            thickness: .5,
                          )),
                          Text(
                            "Or continue with",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.black54,
                            indent: 5,
                            thickness: .5,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      GoogleAuthImage(
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.doctorRegisterScreen);
                            },
                            child: KTextUtils(
                              text: "Register as a doctor !?",
                              color: black,
                              fontWeight: FontWeight.w500,
                              size: 15,
                              textDecoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      )
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