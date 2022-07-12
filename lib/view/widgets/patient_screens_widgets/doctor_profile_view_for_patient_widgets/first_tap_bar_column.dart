import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/my_string.dart';
import 'package:psychology/utils/size_config.dart';

import 'tap_bar_profile_widget.dart';

class FirstTapBarWidget extends StatelessWidget {
  String doctorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackGroundColor,
      body: ListView(
        children: [
          TabBarProfileWidget(
            field: experienceCollectionKey,
            doctorId: doctorId,
          ),
          SizedBox(
            height: SizeConfig.defaultSize,
          ),
          TabBarProfileWidget(
            field: educationCollectionKey,
            doctorId: doctorId,
          ),
        ],
      ),
    );
  }

  FirstTapBarWidget({
    required this.doctorId,
  });
}
