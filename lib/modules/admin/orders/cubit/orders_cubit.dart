

import 'package:cloth_shop/models/order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'orders_states.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);
  List<OrderModel> orders = [];

  loadOrders() {
    // emit(OrdersLoadingState());
    //
    // FirebaseFireStoreService.getProducts().then((value) {
    //   for (var doc in value.docs) {
    //     var data = doc.data();
    //     products.add(ProductModel(
    //         pId: doc.id,
    //         pPrice: data[kProductPrice],
    //         pName: data[kProductName],
    //         pColor: data[kProductColor],
    //         pImageUrl: data[kProductImageUrl],
    //         pDescription: data[kProductDescription],
    //         pCategory: data[kProductCategory]));
    //   }
    //
    //   loadOneCategoryProductForAdmin(searchCategory: kBags);
    //   emit(OrdersSuccessState());
    // }).catchError((onError) {
    //   print("Error ========== $onError");
    //   emit(OrdersErrorState(onError));
    // });
  }
}
