import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/images/icons/back.svg",
            color: kSecondaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/images/icons/cart.svg",
            color: kSecondaryColor,
          ),
          onPressed: () {
            showToast(message: 'Moving to cart screen', error: false);
          },
        ),
      ],
    );
  }
}
