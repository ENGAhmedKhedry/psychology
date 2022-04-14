import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/routes/routes.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';

class HomeScreenDoctorContainerBocking extends StatelessWidget {
  String name;
  String description;
  String imageUrl;
  String uid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.defaultSize! * 13,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.doctorProfileViewForPatient,
                    arguments: [uid, imageUrl, name, description]);
              },
              child: ClipRRect(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: SizeConfig.defaultSize! * 7,
                    width: SizeConfig.defaultSize! * 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),

                    ),
                    child: ClipRRect(
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
              width: SizeConfig.defaultSize! * .2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: SizeConfig.defaultSize! * 2,
                  width: SizeConfig.defaultSize! * 6.8,
                  child: Text(
                    "Dr. $name",
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize! * .9,
                      color: black,
                      fontWeight: FontWeight.w900,
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                SizedBox(
                  width: SizeConfig.defaultSize! * 6.8,
                  child: Text(
                    description +
                        description +
                        description +
                        description +
                        description +
                        description +
                        description +
                        description +
                        description +
                        description,
                    style: const TextStyle(
                      fontSize: 10,
                      color: grey,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.defaultSize! * 4.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildIcon(),
                      buildIcon(),
                      buildIcon(),
                      buildIcon(),
                      buildIcon(),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize,
                ),

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
      size: 12,
    );
  }

  HomeScreenDoctorContainerBocking({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.uid,
  });
}
