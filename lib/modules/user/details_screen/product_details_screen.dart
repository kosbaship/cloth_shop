import 'package:cloth_shop/modules/user/tab_structure/widgets/add_buynow.dart';
import 'package:cloth_shop/modules/user/tab_structure/widgets/counter_favorite.dart';
import 'package:cloth_shop/modules/user/tab_structure/widgets/custom_app_bar.dart';
import 'package:cloth_shop/modules/user/tab_structure/widgets/name_photo_price.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final heroTag;
  final int itemCount;
  final Color color;
  final String imageUrl;
  final String itemName;
  final String itemPrice;

  ProductDetailsScreen(
      {this.heroTag,
      this.itemCount,
      this.color,
      this.imageUrl,
      this.itemName,
      this.itemPrice});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        // this will come from the db
        backgroundColor: kProductColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height,
                  child: Stack(
                    children: <Widget>[
                      CustomAppBar(),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.35),
                        padding: EdgeInsets.only(
                          top: size.height * 0.12,
                          left: 20,
                          right: 20,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            // description
                            Text(
                              'product.description product.description product.description product.description product.description product.description product.description product.description product.description product.description ',
                              style: TextStyle(height: 1.5),
                            ),
                            SizedBox(height: 20),
                            // favorite
                            CounterAndFavorite(),
                            SizedBox(height: 20),
                            // buy now
                            AddToCartAndBuyNow()
                          ],
                        ),
                      ),
                      NameAndPhotoAndPrice(
                        heroTag: heroTag,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
