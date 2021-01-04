import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/add_products/cubit/add_product_cubit.dart';
import 'package:cloth_shop/modules/admin/add_products/cubit/add_product_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (context, state) {
          // buildProgressDialog(
          //   context: context,
          //   text: "Bad Request",
          //   error: true,
          // );
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! AddProductLoadingState,
            builder: (context) => SingleChildScrollView(
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
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: buildDefaultButton(
                          onPressed: () {
                            String name = nameController.text;
                            String price = priceController.text;
                            String description = descriptionController.text;
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
                              AddProductCubit.get(context).saveProduct(
                                  product: ProductModel(
                                      pName: name,
                                      pPrice: price,
                                      pDescription: description,
                                      pCategory: category,
                                      pLocation: location));
                              // nameController.clear();
                              // priceController.clear();
                              // descriptionController.clear();
                              // categoryController.clear();
                              // locationController.clear();
                              // AdminHomeCubit.get(context).currentIndex = 2;
                              // navigateAndFinish(context, AdminHomeScreen());
                              showToast(
                                  message: "Product Saved Successfully",
                                  error: false);
                            }
                          },
                          text: 'Submit',
                          textColor: kWhiteColor,
                          backgroundColor: kMainColor,
                          borderColor: kWhiteColor),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
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
