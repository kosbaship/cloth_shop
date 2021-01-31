import 'package:cloth_shop/models/order.dart';
import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'orders_states.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);
  List<OrderModel> orders = [];
  List<ProductModel> userOrderProducts = [];
  List<String> userIDs = [];


  loadOrders() {
    emit(OrdersLoadingState());

    FirebaseFireStoreService.getOrders().then((value) {
      for (var doc in value.docs) {
        var data = doc.data();
        orders.add
          (OrderModel
          (
            oUserId: data[kUserID],
            oPhone: data[kPhone],
            oAddress: data[kAddress],
            oTotalPrice: data[kTotalPrice],
        )
        );
        userIDs.add(data[kUserID]);
      // loadOrdersDetails(data[kUserID]);
      }
      print("User IDs ========== ${userIDs.length}");

      emit(OrdersSuccessState());
    }).catchError((onError) {
      print("Error ========== $onError");
      emit(OrdersErrorState(onError));
    });
  }

   loadOrdersDetails({index}) {

     FirebaseFireStoreService.getOrdersDetails(userId:userIDs[index]).then((value) {
       for (var doc in value.docs) {
         var data = doc.data();
         userOrderProducts.add(ProductModel(
             pId: doc.id,
             pName: data[kProductName],
             pQuantity: data[kProductQuantity],
             pImageUrl: data[kProductImageUrl]));
       }
       emit(OrdersSuccessState());

     });
   }
}
