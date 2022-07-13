import 'package:flutter/material.dart';
import 'package:psychology/utils/constants.dart';
import 'package:psychology/utils/size_config.dart';
import 'package:psychology/view/screens/call_screens/answer_call/answer_call_wrap_layout.dart';
import 'package:psychology/view/widgets/patient_screens_widgets/chat_widget/chat_room_list_view.dart';
 import 'package:psychology/view/widgets/patient_screens_widgets/chat_widget/chat_search_widget.dart';
 import 'package:psychology/view/widgets/utils_widgets/text_utils.dart';

class PatientChatScreen extends StatelessWidget {
  const PatientChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnswerCallWrapLayout(
      scaffold: Scaffold(
          backgroundColor: homeBackGroundColor,
          //   appBar: AppBar(  elevation: 2,
          // backgroundColor: mainColor2,
          // title: KTextUtils(
          //   text: "Messages",
          //   size: 25,
          //   color: white,
          //   fontWeight: FontWeight.bold,
          //   textDecoration: TextDecoration.none),),
          body: CustomScrollView(
            slivers: [
              // SizedBox(
              //   height: SizeConfig.defaultSize,
              // ),
              // Container(
              //   alignment: Alignment.topLeft,
              //   margin: EdgeInsets.only(left: SizeConfig.defaultSize! * .9),
              //   child: KTextUtils(
              //       text: "Messages",
              //       size: 25,
              //       color: black,
              //       fontWeight: FontWeight.bold,
              //       textDecoration: TextDecoration.none),
              // ),
              SliverAppBar(
                elevation: 2,
                floating: true,
                leadingWidth: 0,
                leading: SizedBox(
                  width: 0,
                ),
                backgroundColor: mainColor2,
                title: KTextUtils(
                    text: "Messages",
                    size: 25,
                    color: white,
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.none),
              ),
           //   SliverToBoxAdapter(child: SearchWidget()),

              // SliverToBoxAdapter(
              //   child: Container(
              //     alignment: Alignment.topLeft,
              //     margin: EdgeInsets.only(left: SizeConfig.defaultSize! * .9),
              //     child: KTextUtils(
              //         text: "Online",
              //         size: SizeConfig.defaultSize! * 1.2,
              //         color: black,
              //         fontWeight: FontWeight.w800,
              //         textDecoration: TextDecoration.none),
              //   ),
              // ),
              // SliverToBoxAdapter(child: OnlineDoctorsChat()),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: SizeConfig.defaultSize,
                ),
              ),

              // SliverToBoxAdapter(
              //   child: Container(
              //     alignment: Alignment.topLeft,
              //     margin: EdgeInsets.only(left: SizeConfig.defaultSize! * .8),
              //     child: KTextUtils(
              //         text: "Messages",
              //         size: SizeConfig.defaultSize! * 1.2,
              //         color: Colors.black87,
              //         fontWeight: FontWeight.w700,
              //         textDecoration: TextDecoration.none),
              //   ),
              // ),

             SliverToBoxAdapter(child: ChatListViewChatRoomsList())
            ],
          )),
    );
  }
}
