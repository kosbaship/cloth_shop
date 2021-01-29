import 'package:cloth_shop/modules/user/product_details_screen/cubit/product_details_cubit.dart';
import 'package:cloth_shop/modules/user/product_details_screen/cubit/product_details_states.dart';
import 'package:cloth_shop/modules/user/product_details_screen/widgets/add_buynow.dart';
import 'package:cloth_shop/modules/user/product_details_screen/widgets/counter_favorite.dart';
import 'package:cloth_shop/modules/user/product_details_screen/widgets/custom_app_bar.dart';
import 'package:cloth_shop/modules/user/product_details_screen/widgets/name_photo_price.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String itemHeroTag;
  final Color itemBackGroundColor;
  final String itemImageUrl;
  final String itemName;
  final String itemPrice;
  final String itemCategories;
  final String itemDescription;

  ProductDetailsScreen(
      {this.itemHeroTag,
      this.itemBackGroundColor,
      this.itemImageUrl,
      this.itemName,
      this.itemPrice,
      this.itemCategories,
      this.itemDescription});

  @override
  Widget build(BuildContext context)  {
    Size size = MediaQuery.of(context).size;
    
    return BlocProvider(
      create: (context) => ProductDetailsScreenCubit(),
      child:BlocConsumer<ProductDetailsScreenCubit, ProductDetailsScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          int intCounter = ProductDetailsScreenCubit.get(context).counter;
          String currentMode = ProductDetailsScreenCubit.get(context).currentMode;
          String favoriteMode = ProductDetailsScreenCubit.get(context).favoriteMode;
          String unFavoriteMode = ProductDetailsScreenCubit.get(context).unFavoriteMode;
          return Scaffold(
            // this will come from the db
              backgroundColor: itemBackGroundColor,
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
                                color: kMainColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  // description
                                  Text(
                                    itemDescription,
                                    style: TextStyle(height: 1.5),
                                  ),
                                  SizedBox(height: 20),
                                  // favorite
                                  CounterAndFavorite(
                                    intCounter: intCounter,
                                    currentMode: currentMode,
                                    favoriteMode: favoriteMode,
                                    unFavoriteMode: unFavoriteMode,
                                  ),
                                  SizedBox(height: 20),
                                  // buy now
                                  AddToCartAndBuyNow(
                                    itemName: itemName,
                                    itemImageUrl: itemImageUrl,
                                    itemPrice: itemPrice,
                                    itemBackGroundColor: itemBackGroundColor,
                                  )
                                ],
                              ),
                            ),
                            NameAndPhotoAndPrice(
                              itemHeroTag: itemHeroTag,
                              itemName: itemName,
                              itemCategories: itemCategories,
                              itemImageUrl: itemImageUrl,
                              itemPrice: itemPrice,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
      )
    );
  }
}
