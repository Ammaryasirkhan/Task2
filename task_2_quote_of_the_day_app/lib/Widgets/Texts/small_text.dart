import 'package:flutter/material.dart';

import '../../Utilities/dimensions.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  final Color? color;
  final String text;

  double size;
  double height;
  SmallText({
    Key? key,
    this.color = const Color(0xff202020),
    required this.text,
    this.size = 0,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        height: height,
        fontSize: size == 0 ? Dimensions.height15 : size,
        fontFamily: "Roboto",
      ),
    );
  }
}
