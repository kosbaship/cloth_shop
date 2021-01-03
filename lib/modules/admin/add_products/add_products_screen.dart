import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/add_products/cubit/add_product_cubit.dart';
import 'package:cloth_shop/modules/admin/add_products/cubit/add_product_states.dart';
import 'package:cloth_shop/modules/admin/home/admin_home_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
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
          if (state is AddProductLoadingState) {
            buildProgressDialog(
              context: context,
              text: 'please wait ...',
            );
          }

          if (state is AddProductSuccessState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            navigateAndFinish(
              context,
              AdminHomeScreen(),
            );
            showToast(message: "Product Saved Successfully", error: false);
          }

          if (state is AddProductErrorState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            buildProgressDialog(
              context: context,
              text: "Bad Request",
              error: true,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                                message: "please fill your data", error: true);
                          } else {
                            AddProductCubit.get(context).saveProduct(
                                product: Product(
                                    pName: name,
                                    pPrice: price,
                                    pDescription: description,
                                    pCategory: category,
                                    pLocation: location));
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
          );
        },
      ),
    );
  }
}
