import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor2,
        title: Text(
          "Search",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: TextFormField(
                    onChanged: (value) {
                      ////////////////////////////////////////
                    },
                    controller: search,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
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
      ),
    );
  }
}
