import 'package:cloth_shop/modules/user/tab_structure/user_product_model_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
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
                Icons.shopping_cart,
                size: 34,
              ),
              onPressed: () {
                showToast(message: "cart", error: false);
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
    );
  }
}
