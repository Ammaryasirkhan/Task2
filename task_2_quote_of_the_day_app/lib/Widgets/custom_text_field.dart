import 'package:flutter/material.dart';

import '../Utilities/colors.dart';
import '../Utilities/dimensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final TextInputType keyboardType;

  CustomTextField({
    required this.controller,
    this.isPassword = false,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: ColorRes.app,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimensions.height10,
          vertical: Dimensions.height20,
        ),
      ),
    );
  }
}
