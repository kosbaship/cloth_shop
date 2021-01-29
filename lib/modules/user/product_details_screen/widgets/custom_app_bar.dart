import 'package:cloth_shop/modules/user/cart/cart_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kMainColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: kMainColor,
            size: 30,
          ),
          onPressed: () {
              navigateToReplaceMe(context, CartScreen());
            },
        ),
      ],
    );
  }
}
