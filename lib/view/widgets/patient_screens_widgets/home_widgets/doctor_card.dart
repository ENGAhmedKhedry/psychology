import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/model/patint_info_model.dart';
import 'package:psychology/routes/routes.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

class DoctorCard extends StatelessWidget {
  String name;
  String description;
  String imageUrl;
  String uid;
  UserModel doctorInfo;

  DoctorCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.uid,
    required this.doctorInfo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell( onTap: () {
              Get.toNamed(Routes.doctorProfileViewForPatient,
                  arguments: [uid, imageUrl, name, description,doctorInfo]);
            },
              child: ClipRRect(
                child: Card(elevation:
                  4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: SizeConfig.defaultSize! * 7,
                    width: SizeConfig.defaultSize! * 7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                    ),child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/animations/loading.gif",
                        image: imageUrl),
                  ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.defaultSize! * .3,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: Get.width*.5,
                  child: KTextUtils(
                      text:"Dr. "+ name,
                      size: 18,
                      color: black,
                      fontWeight: FontWeight.w700,
                      textDecoration: TextDecoration.none),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: SizeConfig.defaultSize! * 8,
                  child: Text(
                    description  ,
                    style: TextStyle(
                      fontSize: 10,
                      color: grey,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * .5,
                ),
                // SizedBox(
                //   width: SizeConfig.defaultSize! * 8,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       buildIcon(),
                //       buildIcon(),
                //       buildIcon(),
                //       buildIcon(),
                //       buildIcon(),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 5,
                ),
                // SizedBox(
                //   width: SizeConfig.defaultSize! * 7,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       KTextUtils(
                //           text: " \$ 200EGP",
                //           size: SizeConfig.defaultSize! * 0.58,
                //           color: black,
                //           fontWeight: FontWeight.w600,
                //           textDecoration: TextDecoration.none),
                //       Spacer(),
                //       SizedBox(
                //         height: SizeConfig.defaultSize! * 1.2,
                //         width: SizeConfig.defaultSize! * 4.2,
                //         child: ElevatedButton(
                //             style: ElevatedButton.styleFrom(
                //               padding: EdgeInsets.all(0),
                //               primary: mainColor2, // background
                //             ),
                //             onPressed: () {},
                //             child: KTextUtils(
                //                 text: "Bock Now",
                //                 size: SizeConfig.defaultSize! * .7,
                //                 color: white,
                //                 fontWeight: FontWeight.w800,
                //                 textDecoration: TextDecoration.none)),
                //       )
                //     ],
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Icon buildIcon() {
    return Icon(
      Icons.star,
      color: Colors.orangeAccent,
      size: 15,
    );
  }
}
