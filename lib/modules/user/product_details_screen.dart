import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailsScreen extends StatelessWidget {
  final heroTag;

  const ProductDetailsScreen({this.heroTag});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        // this will come from the db
        backgroundColor: kProductColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: size.height,
                  child: Stack(
                    children: <Widget>[
                      Row(
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
                              showToast(
                                  message: 'Moving to cart screen',
                                  error: false);
                            },
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.3),
                        padding: EdgeInsets.only(
                          top: size.height * 0.15,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 48,
                                      height: 40,
                                      child: OutlineButton(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        onPressed: () {
                                          showToast(
                                              message: 'Decrement',
                                              error: false);
                                        },
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        // if our item is less  then 10 then  it shows 01 02 like that
                                        1.toString().padLeft(2, "0"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 48,
                                      height: 40,
                                      child: OutlineButton(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        onPressed: () {
                                          showToast(
                                              message: 'Increment',
                                              error: false);
                                        },
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: kRedFavColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      showToast(
                                          message: 'add to Favorite',
                                          error: false);
                                    },
                                    child: SvgPicture.asset(
                                      "assets/images/icons/heart.svg",
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            // buy now
                            Row(
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
                                      showToast(
                                          message: 'add to cart', error: false);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      color: kProductColor,
                                      onPressed: () {
                                        showToast(
                                            message: 'Buy  Now', error: false);
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
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                            ),
                            Text(
                              "Bags Categories".toUpperCase(),
                              style: TextStyle(color: kSecondaryColor),
                            ),
                            Text(
                              "Hand Bag",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      color: kSecondaryColor,
                                      fontWeight: FontWeight.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: "\nPrice\n"),
                                      TextSpan(
                                        text: "EGP 234",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Hero(
                                    tag: '$heroTag',
                                    child: Image.asset(
                                      'assets/images/bags/bag_1.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
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
