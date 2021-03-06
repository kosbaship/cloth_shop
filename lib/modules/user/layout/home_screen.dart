import 'package:cloth_shop/modules/login/login_screen.dart';
import 'package:cloth_shop/modules/user/cart/cart_screen.dart';
import 'package:cloth_shop/modules/user/tabs/cubit/user_product_model_cubit.dart';
import 'package:cloth_shop/modules/user/tabs/user_product_model_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserProductModelCubit()..loadAllProductForUser(),),
      ],
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: kMainColor,
          appBar: AppBar(
            backgroundColor: kMainColor,
            title: Text(
              'Discover'.toUpperCase(),
              style: TextStyle(
                color: kBlackColor,
                fontSize: 24,
              ),
            ),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  size: 34,
                  color: kSecondaryColor,
                ),
                onPressed: () {
                  navigateAndFinish(context, LoginScreen());
                  UserProductModelCubit.get(context).signOut();
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 34,
                ),
                onPressed: () {
                  navigateTo(context, CartScreen());
                },
              ),
              SizedBox(
                width: 12,
              )
            ],
            bottom: TabBar(
              indicatorColor: kBlackColor,
              indicatorWeight: 6,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: kTextLightColor,
              labelColor: kBlackColor,
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
              UserProductModelScreen(searchCategory: kBags),
              UserProductModelScreen(searchCategory: kJackets),
              UserProductModelScreen(searchCategory: kTrousers),
              UserProductModelScreen(searchCategory: kTShirts),
              UserProductModelScreen(searchCategory: kShoes),
            ],
          ),
        ),
      ),
    );
  }
}
