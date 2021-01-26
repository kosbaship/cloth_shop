import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/home/admin_home_screen.dart';
import 'package:cloth_shop/modules/user/cart/cubit/cart_screen_cubit.dart';
import 'package:cloth_shop/modules/user/cart/cubit/cart_screen_states.dart';
import 'package:cloth_shop/modules/user/layout/home_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  final addressController = TextEditingController();
  final phoneController = TextEditingController();


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
                resizeToAvoidBottomPadding: false,
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
                          text: '${CartScreenCubit.get(context).getTotalPrice()}',
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
                            showCustomDialog(context);

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
              fallback: (context) => Scaffold(
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
                  elevation: 0,

                ),
                body: Center(child: Text(
                  'your cart is empty'.toUpperCase(),
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 18,
                  ),
                ),),
              ),

            ),
            fallback: (context) => Scaffold(
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
                elevation: 0,

              ),
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }


  void showCustomDialog(context) async {
    var address;
    Dialog alertDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        height: 420.0,
        width: 360.0,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Text(
                "You Info, Please",
                style: TextStyle(fontSize: 24, color: kItemBackGroundColor, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 12),
            Container(height: 2, color: kItemBackGroundColor),
            SizedBox(height: 12),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Total Price",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: kTextLightColor, fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: " EGP ",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: kBlackColor, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${CartScreenCubit.get(context).getTotalPrice()}',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: kItemBackGroundColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(height: 2, color: kItemBackGroundColor),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: addressController,
                keyboardType: TextInputType.text,
                cursorColor: kMainColor,
                decoration: InputDecoration(
                  hintText: 'Your Address',
                  hintStyle: TextStyle(
                    color: kTextLightColor,
                  ),
                  prefixIcon: Icon(
                    Icons.edit_location_sharp,
                    color: kItemBackGroundColor,
                  ),
                  filled: true,
                  fillColor: kSecondaryColor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kItemBackGroundColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kItemBackGroundColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kItemBackGroundColor)),
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(height: 2, color: kItemBackGroundColor),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                cursorColor: kMainColor,
                decoration: InputDecoration(
                  hintText: 'Your Phone',
                  hintStyle: TextStyle(
                    color: kTextLightColor,
                  ),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: kItemBackGroundColor,
                  ),
                  filled: true,
                  fillColor: kSecondaryColor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kItemBackGroundColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kItemBackGroundColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kItemBackGroundColor)),
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(height: 2, color: kItemBackGroundColor),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: buildDefaultButton(
                  onPressed: () {

                    String userAddress = addressController.text;
                    String userPhone = phoneController.text;

                    if (userAddress.isEmpty || userPhone.isEmpty) {
                      showToast(
                          message: "please fill your data",
                          error: true);
                    } else {
                      CartScreenCubit.get(context).saveOrder(shippingAddress: userAddress, phone: userPhone);
                      showToast(
                          message: "Order Confirmed Successfully",
                          error: false);
                      CartScreenCubit.get(context).emptyCurrentUserCart();
                      navigateToReplaceMe(context, HomeScreen());
                    }
                  },
                  text: 'Submit',
                  textColor: kWhiteColor,
                  backgroundColor: kItemBackGroundColor,
                  borderColor: kWhiteColor),
            ),
          ],
        ),
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }


}