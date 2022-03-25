import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/Divider_widget.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/more_thera_Grid_view_widget.dart';

import '../../widgets/patient_screens_widgets/home_widgets/popular_doctors_list_view.dart';
import '../../widgets/patient_screens_widgets/home_widgets/user_image_and_name.dart';

class PatientHomeScreen extends StatelessWidget {
  PatientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: homeBackGroundColor,
        appBar: AppBar(
          //centerTitle: true,
          title: const Text(
            "Home",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
          backgroundColor: mainColor2,
          elevation: 2,
        ),
        body: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   floating: true,
            //   title: const Text(
            //   "Home",
            //   style: TextStyle(fontSize: 25,
            //     fontWeight: FontWeight.bold,
            //     color: white,
            //   ),
            // ),
            //   backgroundColor: mainColor2,
            //   elevation: 2,),
            SliverToBoxAdapter(child: UserImageAndName()),
            SliverToBoxAdapter(
              child: PopularDoctorsListView(),
            ),
            // DividerWidget(),
            // DoctorOnlineList(),
            // دول هنحطهم ف الشات  هنظهر الدكاتره  الonlineفي الشات بس

            SliverToBoxAdapter(child: DividerWidget()),
            SliverToBoxAdapter(child: MoreTherapistsGridViewWidget()),
          ],
        ));
  }
}
