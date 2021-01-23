import 'package:cloth_shop/modules/admin/products/manage_products/manage_products_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class ManageProductsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            // IconButton(
            //   icon: Icon(
            //     Icons.shopping_cart,
            //     size: 34,
            //   ),
            //   onPressed: () {
            //     showToast(message: "cart", error: false);
            //   },
            // ),
            // SizedBox(
            //   width: 12,
            // )
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
            ManageProductScreen(),
            // Center(
            //   child: Text(
            //     'Discover'.toUpperCase(),
            //   ),
            // ),
            Center(
              child: Text(
                'Discover'.toUpperCase(),
              ),
            ),
            Center(
              child: Text(
                'Discover'.toUpperCase(),
              ),
            ),
            Center(
              child: Text(
                'Discover'.toUpperCase(),
              ),
            ),
            Center(
              child: Text(
                'Discover'.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}