import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddToCartAndBuyNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 20),
          width: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: kProductColor,
            ),
          ),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/images/icons/add_to_cart.svg",
              color: kProductColor,
            ),
            onPressed: () {
              showToast(message: 'add to cart', error: false);
            },
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: kProductColor,
              onPressed: () {
                showToast(message: 'Buy  Now', error: false);
              },
              child: Text(
                "Buy  Now".toUpperCase(),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
