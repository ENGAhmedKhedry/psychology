import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return buildPostItem(
                  context,
                  index,
                );
              },
              childCount: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(
    // PostModel model,
    BuildContext context,
    int index,
    //int commentsNum,
  ) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /////صورة واسم اليوزر
              GestureDetector(
                onTap: () {
                  // if (SocialAppCubit.get(context).postsList[index].uId ==
                  //     uId) {
                  //   SocialAppCubit.get(context).changeBottomNavBarIndex(4);
                  //   //   MyNavigators.navigateTo(context, SettingsScreen());
                  // } else if (SocialAppCubit.get(context)
                  //     .postsList[index]
                  //     .uId !=
                  //     uId) {
                  //   SocialAppCubit.get(context).getFriendData(
                  //       SocialAppCubit.get(context).postsList[index].uId);
                  //   MyNavigators.navigateTo(
                  //       context,
                  //       FriendProfile(
                  //         friendId: SocialAppCubit.get(context)
                  //             .postsList[index]
                  //             .uId,
                  //       ));
                  // }
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000'),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Dr ibrahim atef',
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
                          /////////////التااااااااااااريخ//////////////
                          // Text(
                          //   DateFormat.yMMMd().format(model.date),
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .caption!
                          //       .copyWith(height: 1.4),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15)
                  ],
                ),
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
                'you r insane and incurable you r insane and incurable you r insane and incurable you r insane and incurable',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14,height: 1.5),

              ),
            ],
          ),
        )
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     child: Text(
        //       'Communicate with friends',
        //       style: TextStyle(color: Colors.black),
        //     ),
        //   ),
        // ),

        );
  }
}
