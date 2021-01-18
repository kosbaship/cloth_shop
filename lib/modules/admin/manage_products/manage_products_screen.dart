import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/edit_product/edit_product_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: null, // FirebaseFireStoreService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data();
            products.add(ProductModel(
                pId: doc.id,
                pPrice: data[kProductPrice],
                pName: data[kProductName],
                pDescription: data[kProductDescription],
                pLocation: data[kProductLocation],
                pCategory: data[kProductCategory]));
          }
          return GridView.builder(
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                              productDescription: products[index].pDescription,
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
          );
        } else {
          return Center(
              child: CircularProgressIndicator(backgroundColor: kMainColor));
        }
      },
    );
  }
}
