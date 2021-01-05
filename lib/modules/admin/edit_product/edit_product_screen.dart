import 'package:cloth_shop/modules/admin/edit_product/cubit/edit_product_cubit.dart';
import 'package:cloth_shop/modules/admin/edit_product/cubit/edit_product_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductScreen extends StatelessWidget {
  final String productId;
  final String productName;
  final String productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final locationController = TextEditingController();
  EditProductScreen({
    this.productId,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productCategory,
    this.productLocation,
  });
  @override
  Widget build(BuildContext context) {
    if (productName != null &&
        productPrice != null &&
        productDescription != null &&
        productCategory != null &&
        productLocation != null) {
      nameController.text = productName;
      priceController.text = productPrice;
      descriptionController.text = productDescription;
      categoryController.text = productCategory;
      locationController.text = productLocation;
    }
    return BlocProvider(
      create: (context) => EditProductCubit(),
      child: BlocConsumer<EditProductCubit, EditProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! EditProductLoadingState,
            builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: kMainColor,
                centerTitle: true,
                title: Text("Edit $productName"),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 19,
                      ),
                      buildTextField(
                        icon: Icons.edit,
                        hint: 'Product name',
                        controller: nameController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                        icon: Icons.edit,
                        hint: 'Product price',
                        controller: priceController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                        icon: Icons.edit,
                        hint: 'Product description',
                        controller: descriptionController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                        icon: Icons.edit,
                        hint: 'Product category',
                        controller: categoryController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                        icon: Icons.edit,
                        hint: 'Product location',
                        controller: locationController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 35,
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
                                      .deleteProduct(docId: productId);
                                  Navigator.pop(context);
                                  showToast(
                                      message: "Product Deleted Successfully",
                                      error: false);
                                },
                                color: kMainColor,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
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
                                  String category = categoryController.text;
                                  String location = locationController.text;

                                  if (name.isEmpty ||
                                      price.isEmpty ||
                                      description.isEmpty ||
                                      category.isEmpty ||
                                      location.isEmpty) {
                                    showToast(
                                        message: "please fill your data",
                                        error: true);
                                  } else {
                                    EditProductCubit.get(context).updateProduct(
                                      product: {
                                        kProductName: name,
                                        kProductPrice: price,
                                        kProductDescription: description,
                                        kProductCategory: category,
                                        kProductLocation: location
                                      },
                                      docId: productId,
                                    );
                                    // nameController.clear();
                                    // priceController.clear();
                                    // descriptionController.clear();
                                    // categoryController.clear();
                                    // locationController.clear();
                                    Navigator.pop(context);
                                    showToast(
                                        message: "Product Edited Successfully",
                                        error: false);
                                  }
                                },
                                color: kMainColor,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
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
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
