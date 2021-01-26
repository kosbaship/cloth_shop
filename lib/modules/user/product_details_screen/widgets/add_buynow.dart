import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/user/cart/cart_screen.dart';
import 'package:cloth_shop/modules/user/product_details_screen/cubit/product_details_cubit.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';

class AddToCartAndBuyNow extends StatelessWidget {
  final Color itemBackGroundColor;
  final String itemImageUrl;
  final String itemName;
  final String itemPrice;
  final int itemQuantity ;

  const AddToCartAndBuyNow({this.itemBackGroundColor, this.itemImageUrl, this.itemName, this.itemPrice, this.itemQuantity});

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
              ProductDetailsScreenCubit.get(context).addToCart(
                  product: ProductModel(
                      pName: itemName,
                      pQuantity: ProductDetailsScreenCubit.get(context).counter,
                      pImageUrl: itemImageUrl,
                      pPrice: itemPrice
                  )
              );
              showToast(message: 'Order saved in your cart\n you can continue shopping', error: false);
              Navigator.pop(context);
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

                ProductDetailsScreenCubit.get(context).addToCart(
                  product: ProductModel(
                    pName: itemName,
                    pQuantity: ProductDetailsScreenCubit.get(context).counter,
                    pImageUrl: itemImageUrl,
                    pPrice: itemPrice
                  )
                );
                navigateToReplaceMe(context, CartScreen());
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
