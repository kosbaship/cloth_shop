import 'package:cloth_shop/modules/admin/home/admin_home_screen.dart';
import 'package:cloth_shop/modules/admin/products/edit_product/cubit/edit_product_cubit.dart';
import 'package:cloth_shop/modules/admin/products/edit_product/cubit/edit_product_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductScreen extends StatelessWidget {
  final String itemID;
  final String itemHeroTag;
  final int itemCount;
  final Color itemBackGroundColor;
  final String itemImageUrl;
  final String itemName;
  final String itemPrice;
  final String itemCategories;
  final String itemDescription;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final locationController = TextEditingController();

  EditProductScreen(
      {this.itemHeroTag,
      this.itemCount,
      this.itemBackGroundColor,
      this.itemImageUrl,
      this.itemName,
      this.itemPrice,
      this.itemCategories,
      this.itemDescription,
      this.itemID});

  @override
  Widget build(BuildContext context) {
    if (itemName != null && itemPrice != null && itemDescription != null) {
      nameController.text = itemName;
      priceController.text = itemPrice;
      descriptionController.text = itemDescription;
    }
    return BlocProvider(
      create: (context) => EditProductCubit(),
      child: BlocConsumer<EditProductCubit, EditProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! EditProductLoadingState,
            builder: (context) => Scaffold(
              backgroundColor: kMainColor,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: itemBackGroundColor,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 110,
                          backgroundColor: itemBackGroundColor,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Hero(
                                tag: '$itemHeroTag',
                                child: Image.network(
                                  '$itemImageUrl',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            radius: 100,
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        buildTextField(
                          icon: Icons.edit,
                          hint: 'Product name',
                          controller: nameController,
                          type: TextInputType.text,
                            color: itemBackGroundColor

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                          icon: Icons.edit,
                          hint: 'Product price',
                          controller: priceController,
                          type: TextInputType.number,
                          color: itemBackGroundColor
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextField(
                          icon: Icons.edit,
                          hint: 'Product description',
                          controller: descriptionController,
                          type: TextInputType.text,
                            color: itemBackGroundColor

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    EditProductCubit.get(context)
                                        .deleteProduct(docId: itemID);
                                    Navigator.pop(context);
                                    showToast(
                                        message: "Product Deleted Successfully",
                                        error: false);
                                  },
                                  color: itemBackGroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: kWhiteColor, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    String name = nameController.text;
                                    String price = priceController.text;
                                    String description =
                                        descriptionController.text;

                                    if (name.isEmpty ||
                                        price.isEmpty ||
                                        description.isEmpty) {
                                      showToast(
                                          message: "please fill your data",
                                          error: true);
                                    } else {
                                      EditProductCubit.get(context)
                                          .updateProduct(
                                        product: {
                                          kProductName: name,
                                          kProductPrice: price,
                                          kProductDescription: description,
                                        },
                                        docId: itemID,
                                      );
                                      // nameController.clear();
                                      // priceController.clear();
                                      // descriptionController.clear();
                                      navigateToReplaceMe(
                                          context, AdminHomeScreen());
                                      showToast(
                                          message:
                                              "Product Edited Successfully",
                                          error: false);
                                    }
                                  },
                                  color: itemBackGroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: kWhiteColor, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
