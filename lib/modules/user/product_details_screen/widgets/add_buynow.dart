import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';

class AddToCartAndBuyNow extends StatelessWidget {
  final Color itemBackGroundColor;

  const AddToCartAndBuyNow({this.itemBackGroundColor});

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
              color: itemBackGroundColor,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: itemBackGroundColor,
              size: 30,
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
              color: itemBackGroundColor,
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
