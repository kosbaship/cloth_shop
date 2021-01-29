import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/user/product_details_screen/product_details_screen.dart';
import 'package:cloth_shop/modules/user/tabs/cubit/user_product_model_cubit.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/user_product_model_states.dart';

class UserProductModelScreen extends StatelessWidget {
  final int itemCount;
  final Color color;
  final String imageUrl;
  final String itemName;
  final String itemPrice;
  final String searchCategory;

  UserProductModelScreen(
      {this.itemCount,
      this.color,
      this.imageUrl,
      this.itemName,
      this.itemPrice, this.searchCategory});
  @override
  Widget build(BuildContext context) {
       return BlocConsumer<UserProductModelCubit, UserProductModelStates>(
          listener: (context, state) {},

          builder: (context, state) {
            UserProductModelCubit.get(context).loadOneCategoryProductForUser(searchCategory: searchCategory);

            List<ProductModel> products = UserProductModelCubit.get(context).oneCategoryProductsUser;

            return ConditionalBuilder(
              condition: state is! UserProductModelLoadingState,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      //Color itemBackGroundColor = products[index].pColor as Color;
                      //Color itemBackGroundColor = Color(int.parse(products[index].pColor));
                      Color itemBackGroundColor = kItemBackGroundColor;
                      String itemImageUrl = products[index].pImageUrl;
                      String itemName = products[index].pName;
                      String itemPrice = products[index].pPrice;
                      String itemCategories = products[index].pCategory;
                      String itemDescription = products[index].pDescription;
                      String itemHeroTag = 'details$index';

                      return GestureDetector(
                        onTap: () {
                          navigateTo(
                              context,
                              ProductDetailsScreen(
                                itemHeroTag: itemHeroTag,
                                itemImageUrl: itemImageUrl,
                                itemName: itemName,
                                itemPrice: itemPrice,
                                itemCategories: itemCategories,
                                itemDescription: itemDescription,
                                itemBackGroundColor: itemBackGroundColor,
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                height: 180,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: itemBackGroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Hero(
                                    tag: itemHeroTag,
                                    child: Image.network(
                                      '$itemImageUrl',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                '$itemName',
                                style: TextStyle(color: kTextLightColor),
                              ),
                            ),
                            Text(
                              'EGP $itemPrice',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          },
        );
  }
}
