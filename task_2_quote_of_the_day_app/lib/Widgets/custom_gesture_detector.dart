import 'package:flutter/material.dart';

import '../Utilities/colors.dart';
import '../Utilities/dimensions.dart';
import 'Texts/big_text.dart';

class CustomGestureDetector extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  CustomGestureDetector({
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.height10,
          vertical: Dimensions.height15,
        ),
        decoration: BoxDecoration(
          color: ColorRes.app,
          border: Border.all(color: ColorRes.app),
          borderRadius: BorderRadius.circular(Dimensions.width10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: Dimensions.iconsize20, // Adjust the size as needed
              color: ColorRes.white,
            ),
            SizedBox(
                width: Dimensions
                    .width20), // Add spacing between the icon and text
            BigText(text: text, color: ColorRes.white),
          ],
        ),
      ),
    );
  }
}
