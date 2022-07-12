import 'package:flutter/material.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

class ReviewsAndSissions extends StatelessWidget {
  const ReviewsAndSissions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.defaultSize! * 2,
      width: SizeConfig.screenWidth!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(width: SizeConfig.defaultSize!*1.5 ,height: SizeConfig.defaultSize!*1.5  ,
            //         child: Image.asset("assets/images/dollar.png",fit: BoxFit.cover,)),
            //     KTextUtils(
            //         text: "200 EGP",
            //         size: SizeConfig.defaultSize! * .8,
            //         color: black,
            //         fontWeight: FontWeight.w500,
            //         textDecoration: TextDecoration.none)
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star_purple500_sharp,
                    color: Colors.orangeAccent,size: SizeConfig.defaultSize!*1.5,),
                KTextUtils(
                    text: "0.0",
                    size: SizeConfig.defaultSize! * .8,
                    color: black,
                    fontWeight: FontWeight.w500,
                    textDecoration: TextDecoration.none)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow_rounded, color: mainColor,size: SizeConfig.defaultSize!*1.5,),
                KTextUtils(
                    text: "+0",
                    size: SizeConfig.defaultSize! * .8,
                    color: black,
                    fontWeight: FontWeight.w500,
                    textDecoration: TextDecoration.none),
                KTextUtils(
                    text: " Sessions",
                    size: SizeConfig.defaultSize! * .7,
                    color: grey,
                    fontWeight: FontWeight.w500,
                    textDecoration: TextDecoration.none)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
