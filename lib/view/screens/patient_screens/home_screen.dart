import 'package:flutter/material.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/Divider_widget.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/more_thera_Grid_view_widget.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/online._doctors_list.dart';

import '../../widgets/patient_screens_widgets/home_widgets/popular_doctors_list_view.dart';
import '../../widgets/patient_screens_widgets/home_widgets/user_image_and_name.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackGroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: white,
          ),
        ),
        backgroundColor: mainColor2,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [

            UserImageAndName(),
            PopularDoctorsListView(),
            DividerWidget(),
            DoctorOnlineList(),
            DividerWidget(),
            MoreTherapistsGridViewWidget(),

          ],
        ),
      ),
    );
  }
}
