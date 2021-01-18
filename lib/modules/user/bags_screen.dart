import 'package:cloth_shop/modules/user/product_details_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class BagsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // navigateTo(context, ProductDetailsScreen());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          heroTag: index,
                        ),
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
                          color: Color(0xFF3D82AE),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Hero(
                            tag: '$index',
                            child: Image.asset('assets/images/bags/bag_1.png')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Office Bag',
                        style: TextStyle(color: kTextLightColor),
                      ),
                    ),
                    Text(
                      '234 EGP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )),
    );
  }
}
