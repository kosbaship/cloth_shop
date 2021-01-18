import 'package:bloc/bloc.dart';
import 'package:cloth_shop/modules/admin/add_products/add_products_screen.dart';
import 'package:cloth_shop/modules/admin/home/cubit/admin_home_states.dart';
import 'package:cloth_shop/modules/admin/manage_products/manage_products_screen.dart';
import 'package:cloth_shop/modules/admin/orders/orders_screen.dart';
import 'package:cloth_shop/network/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeCubit extends Cubit<AdminHomeStates> {
  AdminHomeCubit() : super(AdminHomeInitialState());

  static AdminHomeCubit get(context) => BlocProvider.of(context);

  var bodies = [AddProductScreen(), OrdersScreen(), ManageProductScreen()];
  var titles = [
    Text("Add Product"),
    Text("Manage Orders"),
    Text("Manage Products")
  ];

  int currentIndex = 1;
  changeIndex(index) {
    currentIndex = index;
    emit(AdminHomeIndexState());
  }

  signOut() {
    FirebaseAuthService.signOut();
  }
}
