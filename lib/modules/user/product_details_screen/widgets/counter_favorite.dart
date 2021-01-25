import 'package:cloth_shop/modules/user/product_details_screen/cubit/product_details_cubit.dart';
import 'package:cloth_shop/modules/user/product_details_screen/cubit/product_details_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterAndFavorite extends StatelessWidget {

final  int intCounter ;
final  String currentMode;
final String favoriteMode ;
final String unFavoriteMode;

  const CounterAndFavorite({this.currentMode, this.favoriteMode, this.unFavoriteMode, this.intCounter});

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
                  borderRadius: BorderRadius.circular(13),
                ),
                onPressed: () {
                  if (intCounter == 1) {
                    showToast(message: 'not allowed', error: false);
                  } else {
                    ProductDetailsScreenCubit.get(context).minus();
                  }
                },
                child: Icon(Icons.remove),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                // if our item is less  then 10 then  it shows 01 02 like that
                intCounter.toString().padLeft(2, "0"),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              width: 48,
              height: 40,
              child: OutlineButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                onPressed: () {
                  ProductDetailsScreenCubit.get(context).plus();
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 4),
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: kRedFavColor,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
              onTap: () {
                if (currentMode == favoriteMode) {
                  ProductDetailsScreenCubit.get(context).removeFromMyFavorite();
                  print('$currentMode');
                } else if(currentMode == unFavoriteMode){
                  ProductDetailsScreenCubit.get(context).addToFavorite();
                  print('$currentMode');

                }
              },
              child: currentMode == unFavoriteMode
                  ? Icon(
                Icons.favorite_border_outlined,
                color: kSecondaryColor,
                size: 35,
              )
                  : Icon(
                Icons.favorite_outlined,
                color: kSecondaryColor,
                size: 35,
              )),
        )
      ],
    );
  }
}
