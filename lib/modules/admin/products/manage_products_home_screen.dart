import 'package:cloth_shop/modules/admin/products/add_products/add_products_screen.dart';
import 'package:cloth_shop/modules/admin/products/manage_products/cubit/manage_products_screen_cubit.dart';
import 'package:cloth_shop/modules/admin/products/manage_products/manage_products_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProductsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageProductsScreensCubit()..loadAllProductForAdmin(),
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: kMainColor,

          appBar: AppBar(
            backgroundColor: kMainColor,
            title: Text(
              'Manage'.toUpperCase(),
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 24,
              ),
            ),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add_box,
                  size: 34,
                  color: kSecondaryColor,
                ),
                onPressed: () {
                  navigateTo(context, AddProductScreen());
                },
              ),
              SizedBox(
                width: 12,
              )
            ],
            bottom: TabBar(
              indicatorColor: kSecondaryColor,
              indicatorWeight: 6,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: kTextDarkColor,
              labelColor: kSecondaryColor,
              isScrollable: true,
              unselectedLabelStyle: TextStyle(
                fontSize: 12,
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: <Widget>[
                Text(
                  'Bags',
                ),
                Text(
                  'Jackets',
                ),
                Text(
                  'Trousers',
                ),
                Text(
                  'T-shirts',
                ),
                Text(
                  'Shoes',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ManageProductScreen(searchCategory: kBags),
              ManageProductScreen(searchCategory: kJackets),
              ManageProductScreen(searchCategory: kTrousers),
              ManageProductScreen(searchCategory: kTShirts),
              ManageProductScreen(searchCategory: kShoes),
            ],
          ),
        ),
      ),
    );
  }
}