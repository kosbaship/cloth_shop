import 'dart:io';
import 'dart:ui';

import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/products/add_products/cubit/add_product_cubit.dart';
import 'package:cloth_shop/modules/admin/products/add_products/cubit/add_product_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Color currentColor = kProductColorLocal;
String caterorySelected = 'jackets';

class AddProductScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          String imageLink = AddProductCubit.get(context).imageLink;

          return ConditionalBuilder(
            condition: state is! AddProductLoadingState,
            builder: (context) {
              return Scaffold(
                backgroundColor: kMainColor,
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: kSecondaryColor,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),

                          imageLink != ''
                              ? CircleAvatar(
                                  radius: 110,
                                  backgroundColor: kSecondaryColor,
                                  child: CircleAvatar(
                                    backgroundColor: kMainColor,
                                    child: ClipOval(
                                      child: Image.file(
                                        File(imageLink),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    radius: 100,
                                  ),
                                )
                              : FlatButton(
                                  onPressed: () {
                                    AddProductCubit.get(context).selectImage();
                                  },
                                  color: kMainColor,
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    // Replace with a Row for horizontal icon + text
                                    children: <Widget>[
                                      Icon(
                                        Icons.camera,
                                        size: 120,
                                        color: kSecondaryColor,
                                      ),
                                      Text(
                                        "Choose Image",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                              color: kTextLightColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: 19,
                          ),
                          buildTextField(
                            icon: Icons.edit,
                            hint: 'Product name',
                            controller: nameController,
                            type: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildTextField(
                            icon: Icons.edit,
                            hint: 'Product price',
                            controller: priceController,
                            type: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildTextField(
                            icon: Icons.edit,
                            hint: 'Product description',
                            controller: descriptionController,
                            type: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PickColor(),
                          SizedBox(
                            height: 20,
                          ),
                          DropDown(),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: buildDefaultButton(
                                onPressed: () {
                                  String name = nameController.text;
                                  String price = priceController.text;
                                  String description = descriptionController.text;

                                  if (name.isEmpty ||
                                      price.isEmpty ||
                                      imageLink == '' ||
                                      description.isEmpty) {
                                    showToast(
                                        message: "please fill your data",
                                        error: true);
                                  } else {
                                    AddProductCubit.get(context).saveProduct(
                                        product: ProductModel(
                                            pName: name,
                                            pPrice: price,
                                            pDescription: description,
                                            pCategory: caterorySelected,
                                            pColor: currentColor.toString().replaceAll('Color(', '')..replaceAll(')', '')));
                                    // nameController.clear();
                                    // priceController.clear();
                                    // descriptionController.clear();
                                    // categoryController.clear();
                                    // locationController.clear();
                                    // AdminHomeCubit.get(context).currentIndex = 2;
                                    // navigateAndFinish(context, AdminHomeScreen());
                                    AddProductCubit.get(context).imageLink = '';
                                    showToast(
                                        message: "Product Saved Successfully",
                                        error: false);
                                  }
                                },
                                text: 'Submit',
                                textColor: kSecondaryColor,
                                backgroundColor: kMainColor,
                                borderColor: kSecondaryColor),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class PickColor extends StatefulWidget {
  @override
  _PickColorState createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  void changeColor(Color color) {
    setState(() {
      return currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 62,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          'Choose Color'.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "MontserratRegular",
          ),
        ),
        color: currentColor,
        textColor: kMainColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(16.0),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlockPicker(
                          pickerColor: currentColor,
                          onColorChanged: changeColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: buildDefaultButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Submit',
                            textColor: kMainColor,
                            backgroundColor: kSecondaryColor,
                            borderColor: kMainColor),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  DropDownState createState() => DropDownState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[

      Company(1, kBags),
      Company(2, kJackets),
      Company(3, kTrousers),
      Company(4, kTShirts),
      Company(5, kShoes),
      // Company(1, 'Bags'),
      // Company(2, 'Jackets'),
      // Company(3, 'Trousers'),
      // Company(4, 'T-shirts'),
      // Company(5, 'Shoes'),
    ];
  }
}

class DropDownState extends State<DropDown> {
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    caterorySelected = _selectedCompany.name;
    print(caterorySelected);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton(
          style: TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: "MontserratRegular",
          ),
          value: _selectedCompany,
          items: _dropdownMenuItems,
          onChanged: onChangeDropdownItem,
        ),
      ],
    );
  }
}
