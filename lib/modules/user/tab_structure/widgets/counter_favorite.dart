import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CounterAndFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
