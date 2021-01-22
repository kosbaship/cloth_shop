import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class NameAndPhotoAndPrice extends StatelessWidget {
  final String itemHeroTag;
  final String itemImageUrl;
  final String itemName;
  final String itemCategories;
  final String itemPrice;
  NameAndPhotoAndPrice(
      {this.itemHeroTag,
      this.itemImageUrl,
      this.itemName,
      this.itemPrice,
      this.itemCategories});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Text(
            "$itemCategories Categories".toUpperCase(),
            style: TextStyle(color: kSecondaryColor),
          ),
          Text(
            "$itemName",
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: kSecondaryColor, fontWeight: FontWeight.bold),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "\nPrice\n"),
                    TextSpan(
                      text: "EGP $itemPrice",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Hero(
                  tag: '$itemHeroTag',
                  child: Image.network(
                    '$itemImageUrl',
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
