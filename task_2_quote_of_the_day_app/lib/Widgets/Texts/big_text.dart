import 'package:flutter/material.dart';

import '../../Utilities/dimensions.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final Color? color;
  final String text;

  double size;
  TextOverflow overflow;
  BigText(
      {Key? key,
      this.color = const Color(0xff202020),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          fontSize: size == 0 ? Dimensions.text20 : size,
          color: color,
          height: 1.9,
          fontFamily: "roboto",
          fontWeight: FontWeight.w400),
    );
  }
}
