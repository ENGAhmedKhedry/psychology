import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/styles.dart';

import '../../../utils/size_config.dart';
import '../../widgets/utils_widgets/height_size_box.dart';
import '../../widgets/utils_widgets/text_utils.dart';

class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor2,
        centerTitle: true,
        title: Text("Your Diagnosis"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(IconBroken.Arrow___Left_2)),
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeightSizeBox(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: Get.width * .23,
                            width: Get.width * .23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Card(
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Get.width * .2)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Get.width * .09),
                                  child:
                                  //SizedBox()
                                  //////////صورة الدكتور//////////
                                  FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      placeholder:
                                      "assets/animations/63065-profile-in-out.gif",
                                      image: 'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000'),
                                  ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          ////////////اسم الدكتور////////
                          KTextUtils(
                              text: 'Dr Ibrahim Atef',
                              size: 20,
                              color: white,
                              fontWeight: FontWeight.w700,
                              textDecoration: TextDecoration.none)
                        ],
                      ),
                      /////////disease name//////
                      HeightSizeBox(30),
                      KTextUtils(
                          text: "Disease Name",
                          size: 20,
                          color: darkGrey,
                          fontWeight: FontWeight.w700,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(10),
                      Container(
                        decoration: BoxDecoration(
                            color:  hentText,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text ('what the hell is that',
                            style:TextStyle(fontSize: 16,height: 1.5) ,),
                        ),
                      ),
                      ///////////diagnosis////////
                      HeightSizeBox(20),
                      KTextUtils(
                          text: "Detailed Diagnosis",
                          size: 20,
                          color: darkGrey,
                          fontWeight: FontWeight.w700,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(10),
                      Container(
                        decoration: BoxDecoration(
                          color: hentText,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text ('aksdgjfaedgjakewdjawdasefaksdgjfaedgjakewdjawdasefaksdgjfaedgjakewdjawdasefaksdgjfaedgjakewdjawdasefaksdgjfaedgjakewdjawdasefaksdgjfaedgjakewdjawdasef',
                            style:TextStyle(fontSize: 16,height: 1.5) ,),
                        ),
                      ),
                      //////////treatment///////
                      HeightSizeBox(30),
                      KTextUtils(
                          text: "Treatment",
                          size: 20,
                          color: darkGrey,
                          fontWeight: FontWeight.w700,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(10),
                      Container(
                        decoration: BoxDecoration(
                            color: hentText,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text ('antibiotic',
                            style:TextStyle(fontSize: 16,height: 1.5) ,),
                        ),
                      )
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
