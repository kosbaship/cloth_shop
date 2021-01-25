import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/user/cart/cubit/cart_screen_cubit.dart';
import 'package:cloth_shop/modules/user/cart/cubit/cart_screen_states.dart';
import 'package:cloth_shop/network/firebase_auth.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {


  const CartScreen();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return BlocProvider(
      create: (context) => CartScreenCubit()..loadUserCartProducts(),
      child: BlocConsumer<CartScreenCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<ProductModel> cartScreenProducts = CartScreenCubit.get(context).cartProducts;
          return ConditionalBuilder(
            condition: state is! CartLoadingState,
            builder: (context) => ConditionalBuilder(
              condition: cartScreenProducts.length != 0,
              builder: (context) => Scaffold(
                backgroundColor: kSecondaryColor,
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kSecondaryColor,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  backgroundColor: kItemBackGroundColor,
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Total Price",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: kSecondaryColor, fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: " EGP ",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: kBlackColor, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${getTotalPrice(cartScreenProducts)}',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: kSecondaryColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  elevation: 0,

                ),
                body: Column(
                  children: <Widget>[
                    LayoutBuilder(builder: (context, constrains) {
                      return Container(
                        height: screenHeight -
                            statusBarHeight -
                            appBarHeight -
                            (screenHeight * .08),
                        child: ListView.builder(
                          itemBuilder: (context, index) {


                            return Padding(
                              padding: const EdgeInsets.all(15),
                              child: GestureDetector(
                                onTapUp: (details) {
                                  // showCustomMenu(details, context, products[index]);
                                },
                                child: Container(
                                  height: screenHeight * .15,
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: screenHeight * .15 / 2,
                                        child:  Image.network(
                                          '${cartScreenProducts[index].pImageUrl}',
                                          fit: BoxFit.fill,
                                        ),
                                        backgroundColor: kItemBackGroundColor,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${cartScreenProducts[index].pName}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'EGP ${cartScreenProducts[index].pPrice}',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20),
                                              child: Text(
                                                '${cartScreenProducts[index].pQuantity}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  color: kSecondaryColor,
                                ),
                              ),
                            );
                          },
                          itemCount: cartScreenProducts.length,
                        ),
                      );

                    }),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(18),
                                  topLeft: Radius.circular(18))),
                          onPressed: () {
                            // showCustomDialog(products, context);
                          },
                          child: Text(
                            "Confirm  Order".toUpperCase(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          color: kItemBackGroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: Text(
                'your cart is empty'.toUpperCase(),
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 18,
                ),
              ),),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  // void showCustomMenu(details, context, product) async {
  //   double dx = details.globalPosition.dx;
  //   double dy = details.globalPosition.dy;
  //   double dx2 = MediaQuery.of(context).size.width - dx;
  //   double dy2 = MediaQuery.of(context).size.width - dy;
  //   await showMenu(
  //       context: context,
  //       position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
  //       items: [
  //         MyPopupMenuItem(
  //           onClick: () {
  //             Navigator.pop(context);
  //             Provider.of<CartItem>(context, listen: false)
  //                 .deleteProduct(product);
  //             Navigator.pushNamed(context, ProductInfo.id, arguments: product);
  //           },
  //           child: Text('Edit'),
  //         ),
  //         MyPopupMenuItem(
  //           onClick: () {
  //             Navigator.pop(context);
  //             Provider.of<CartItem>(context, listen: false)
  //                 .deleteProduct(product);
  //           },
  //           child: Text('Delete'),
  //         ),
  //       ]);
  // }

  // void showCustomDialog(List<Product> products, context) async {
  //   var price = getTotallPrice(products);
  //   var address;
  //   AlertDialog alertDialog = AlertDialog(
  //     actions: <Widget>[
  //       MaterialButton(
  //         onPressed: () {
  //           try {
  //             Store _store = Store();
  //             _store.storeOrders(
  //                 {kTotallPrice: price, kAddress: address}, products);
  //
  //             Scaffold.of(context).showSnackBar(SnackBar(
  //               content: Text('Orderd Successfully'),
  //             ));
  //             Navigator.pop(context);
  //           } catch (ex) {
  //             print(ex.message);
  //           }
  //         },
  //         child: Text('Confirm'),
  //       )
  //     ],
  //     content: TextField(
  //       onChanged: (value) {
  //         address = value;
  //       },
  //       decoration: InputDecoration(hintText: 'Enter your Address'),
  //     ),
  //     title: Text('Totall Price  = \$ $price'),
  //   );
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return alertDialog;
  //       });
  // }

  getTotalPrice(List<ProductModel> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}