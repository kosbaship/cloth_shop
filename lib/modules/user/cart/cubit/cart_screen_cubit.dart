import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen_states.dart';

class CartScreenCubit extends Cubit<CartStates> {
  CartScreenCubit() : super(CartInitialState());

  static CartScreenCubit get(context) => BlocProvider.of(context);


  List<ProductModel> cartProducts = [];
  var price = 0;

  getTotalPrice() {
    price = 0;
    for (var product in cartProducts) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }

  saveOrder({shippingAddress , phone}) {
    emit(CartLoadingState());

    FirebaseFireStoreService.storeOrders(totalPrice: price, shippingAddress:shippingAddress , phone: phone)
        .then((value) {
          FirebaseFireStoreService.storeOrdersDetails(products: cartProducts);
      emit(CartSuccessState());
    }).catchError((e) {
      emit(CartErrorState(e.toString()));
    });
  }




  loadUserCartProducts() {
    emit(CartLoadingState());

    FirebaseFireStoreService.getCartProducts().then((value) {

      for (var doc in value.docs) {
        var data = doc.data();
        cartProducts.add(ProductModel(
            pId: doc.id,
            pPrice: data[kProductPrice],
            pName: data[kProductName],
            pQuantity: data[kProductQuantity],
            pImageUrl: data[kProductImageUrl]));
      }

      emit(CartSuccessState());
    }).catchError((e) {
      emit(CartErrorState(e.toString()));
    });
  }


  emptyCurrentUserCart() {
    emit(CartLoadingState());
    //cartProducts.clear();
    FirebaseFireStoreService.deleteUserCart().then((value) {
      emit(CartSuccessState());
    }).catchError((e) {
      emit(CartErrorState(e.toString()));
    });
  }
}
