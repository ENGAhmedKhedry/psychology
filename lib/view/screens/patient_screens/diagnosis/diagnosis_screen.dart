import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychology/view/screens/patient_screens/diagnosis/diagnosis_details_screen.dart';

import '../../../../controller/controllers/patient_controller/patient_profile_controller.dart';
import '../../../../model/diagnosis_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';

class DiagnosisScreen extends StatelessWidget {
  DiagnosisScreen({Key? key}) : super(key: key);
  final controller = Get.put(PatientProfileController());

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
        child: GetBuilder(
          initState: controller.getMyDiagnosis(),
          builder: (PatientProfileController controller) {
            return controller.patientDiagnosis.length != 0
                ? ListView.builder(
                    itemCount: controller.patientDiagnosis.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildPostItem(
                        controller.patientDiagnosis[index],
                        context,
                        index,
                      );
                    },
                  )
                : Center(
                    child: Text("you have no Diagnosis"),
                  );
          },
        ),
      ),
    );
  }

  Widget buildPostItem(
    DiagnosisModel diagnosisModel,
    BuildContext context,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(DiagnosisDetailsScreenScreen(diagnosisModel: diagnosisModel,));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /////صورة واسم اليوزر
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(diagnosisModel.doctorImage),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dr ${diagnosisModel.doctorName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 16,
                                      height: 1.4,
                                      fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15)
                ],
              ),
              /////Divider////
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ////نص البوست//
              // if (model.text != '')
              Text(
                diagnosisModel.diagnosis,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
