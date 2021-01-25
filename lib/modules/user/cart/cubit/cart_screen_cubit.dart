import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen_states.dart';

class CartScreenCubit extends Cubit<CartStates> {
  CartScreenCubit() : super(CartInitialState());

  static CartScreenCubit get(context) => BlocProvider.of(context);





  // addToCart({ProductModel product}) {
  //   emit(CartLoadingState());
  //
  //   FirebaseFireStoreService.createCollectionAndAddCart(product: product).then((value) {
  //
  //     emit(CartSuccessState());
  //   }).catchError((e) {
  //     emit(CartErrorState(e.toString()));
  //   });
  // }
}
