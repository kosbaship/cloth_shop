import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/edit_product/edit_product_screen.dart';
import 'package:cloth_shop/modules/admin/manage_products/cubit/manage_product_cubit.dart';
import 'package:cloth_shop/modules/admin/manage_products/cubit/manage_products_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageProductCubit()..loadProduct(),
      child: BlocConsumer<ManageProductCubit, ManageProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<ProductModel> products =
              ManageProductCubit.get(context).products;

          return ConditionalBuilder(
            condition: state is! ManageProductLoadingState,
            builder: (context) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Card(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${products[index].pPrice}')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: () {
                            navigateTo(
                              context,
                              EditProductScreen(
                                productId: products[index].pId,
                                productName: products[index].pName,
                                productPrice: products[index].pPrice,
                                productDescription:
                                    products[index].pDescription,
                                productCategory: products[index].pCategory,
                                productLocation: products[index].pLocation,
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.open_in_new_outlined,
                            size: 35,
                            color: kMainColor,
                          ),
                        ),
                        bottom: 0,
                        right: 0,
                      )
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
