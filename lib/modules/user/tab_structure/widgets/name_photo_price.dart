import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class NameAndPhotoAndPrice extends StatelessWidget {
  final heroTag;

  NameAndPhotoAndPrice({this.heroTag});
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
            "Bags Categories".toUpperCase(),
            style: TextStyle(color: kSecondaryColor),
          ),
          Text(
            "Hand Bag",
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
                      text: "EGP 234",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
    );
  }
}
