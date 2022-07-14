import 'package:flutter/material.dart';

class KTextUtils extends StatelessWidget {
  String text;
  double size;
  Color color;
  FontWeight fontWeight;
  TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(text,maxLines: 2,
        style: TextStyle(fontFamily: "cairo",
          fontSize: size,
          color: color,
          fontWeight:fontWeight ,
          decoration:textDecoration,

        ));
  }

  KTextUtils({
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
    required this.textDecoration,
  });
}
