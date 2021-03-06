import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/products/edit_product/edit_product_screen.dart';
import 'package:cloth_shop/modules/admin/products/manage_products/cubit/manage_products_screen_cubit.dart';
import 'package:cloth_shop/modules/admin/products/manage_products/cubit/manage_products_screen_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProductScreen extends StatelessWidget {
  final String searchCategory;

  const ManageProductScreen({@required this.searchCategory});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageProductsScreensCubit, ManageProductsScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ManageProductsScreensCubit.get(context).loadOneCategoryProductForAdmin(searchCategory: searchCategory);

        List<ProductModel> products = ManageProductsScreensCubit.get(context).oneCategoryProductsAdmin;

        return ConditionalBuilder(
          condition: state is! ManageProductsScreenLoadingState,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) {
                  //Color itemBackGroundColor = products[index].pColor as Color;
                  Color itemBackGroundColor = Color(int.parse(products[index].pColor));
                  //Color itemBackGroundColor = kSecondaryColor;
                  String itemID =  products[index].pId;
                  String itemImageUrl = products[index].pImageUrl;
                  String itemName = products[index].pName;
                  String itemPrice = products[index].pPrice;
                  String itemCategories = products[index].pCategory;
                  String itemDescription = products[index].pDescription;
                  String itemHeroTag = 'details$index';

                  return Column(
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                        child: Text(
                          '$itemName',
                          style: TextStyle(color: kTextDarkColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only( left: 10),
                        child: Text(
                          'EGP $itemPrice',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton(

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                navigateTo(
                                    context,
                                    EditProductScreen(
                                      itemID: itemID,
                                      itemHeroTag: itemHeroTag,
                                      itemImageUrl: itemImageUrl,
                                      itemName: itemName,
                                      itemPrice: itemPrice,
                                      itemCategories: itemCategories,
                                      itemDescription: itemDescription,
                                      itemBackGroundColor: itemBackGroundColor,
                                    ));
                              },
                              color: Color(int.parse(products[index].pColor)),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
