import 'package:flutter/material.dart';

class AppIconAndName extends StatelessWidget {
 Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 75,
          width: 75,
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(39)),
            child: Image.asset(
              "assets/images/appicon.png",
              colorBlendMode: BlendMode.hue,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "psychology",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,color: color),
            ),
            Text(
              "Keep Talking..",
              style: TextStyle(fontSize: 14,color: color),
            ),
          ],
        )
      ],
    );
  }

 AppIconAndName({
    required this.color,
  });
}
