import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Discover'.toUpperCase(),
              style: TextStyle(
                color: kSecondaryColor,
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
              unselectedLabelColor: kSecondaryColor,
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
                  'Trouser',
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
              Center(
                child: Text(
                  'Discover'.toUpperCase(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
