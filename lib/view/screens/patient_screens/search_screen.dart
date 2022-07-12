import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/home_widgets/doctor_card.dart';

import '../../../controller/controllers/patient_controller/patient_home_screen_controller.dart';
import '../../../utils/constants.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final controller = Get.put(PatientHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor2,
        title: Text(
          "Search",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Obx(
        () {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: TextFormField(
                        onChanged: (value) {
                          controller.addSearchToList(value);
                        },
                        controller: controller.search,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.addSearchToList(
                                  controller.search.text,
                                );
                                //////////////
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Search ...",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: mainColor2, width: 2),
                                borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: mainColor2, width: 2),
                                borderRadius: BorderRadius.circular(25)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: mainColor2, width: 2),
                                borderRadius: BorderRadius.circular(25))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'search must not be null';
                          }
                          return null;
                        },
                        onFieldSubmitted: (val) {
                          ////////////////////////
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      child: //controller.searchList.isNotEmpty ||
                              controller.isSearching.value == true
                          ? ListView.builder(
                              itemCount: controller.searchList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return DoctorCard(
                                    name: controller
                                        .searchList[index].displayName!,
                                    description:
                                        controller.searchList[index].bio!,
                                    imageUrl: controller
                                        .searchList[index].profileUrl!,
                                    uid: controller.searchList[index].uid!,
                                    doctorInfo: controller.searchList[index]);
                              },
                            )
                          : Center(
                              child: Text(
                                "enter doctor name to search",
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                  //دا شرط ال ليست ينجم ///////

                  // ConditionalBuilder(
                  //   condition: state is! GetAllSearchUserLoadingState,
                  //   builder: (context) => Expanded(
                  //     child: ListView.separated(
                  //         itemBuilder: (context, index) =>
                  //             ChatItem(context, bloc.usersSearch[index]),
                  //         separatorBuilder: (context, index) => SizedBox(),
                  //         itemCount: bloc.usersSearch.length),
                  //   ),
                  //   fallback: (context) =>search.text==''?SizedBox() :LinearProgressIndicator(
                  //     color: social3,
                  //   ),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
