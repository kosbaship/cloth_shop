import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/user/details_screen/product_details_screen.dart';
import 'package:cloth_shop/modules/user/tab_structure/cubit/cubit.dart';
import 'package:cloth_shop/modules/user/tab_structure/cubit/states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagsScreen extends StatelessWidget {
  final int itemCount;
  final Color color;
  final String imageUrl;
  final String itemName;
  final String itemPrice;

  BagsScreen(
      {this.itemCount,
      this.color,
      this.imageUrl,
      this.itemName,
      this.itemPrice});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BagsCubit()..loadProduct(),
      child: BlocConsumer<BagsCubit, BagsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<ProductModel> products = BagsCubit.get(context).products;

          return ConditionalBuilder(
            condition: state is! BagsLoadingState,
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
                    Color itemBackGroundColor = Color(0xff46494a);
                    String itemImageUrl = products[index].pImageUrl;
                    //  print('=-=-=-=-= ${products[index].pImageUrl}');
                    String itemName = products[index].pName;
                    //  print('=-=-=-=-= ${products[index].pName}');
                    String itemPrice = products[index].pPrice;
                    //    print('=-=-=-=-= ${products[index].pPrice}');
                    String itemCategories = products[index].pCategory;
                    //   print('=-=-=-=-= ${products[index].pCategory}');
                    String itemDescription = products[index].pDescription;
                    //   print('=-=-=-=-= ${products[index].pDescription}');
                    String itemHeroTag = 'details$index';
                    //  print('=-=-=-=-= details$index');

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
      ),
    );
  }
}
