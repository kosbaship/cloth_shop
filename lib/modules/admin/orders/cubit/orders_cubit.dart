

import 'package:cloth_shop/models/order.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'orders_states.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);
  List<OrderModel> orders = [];

  loadOrders() {
    emit(OrdersLoadingState());
    print("Orders ========= =============== ====================== ");

    // FirebaseFireStoreService.getOrdersDetails().then((value) {
    //   print("Orders Details ========== ${value.docs}\n");
    //
    //   for (var doc in value.docs) {
    //     var data = doc.data();
    //     print("Orders Details ========== $data\n");
    //   }
    //   emit(OrdersSuccessState());
    // }).catchError((onError) {
    //   print("Error ========== $onError");
    //   emit(OrdersErrorState(onError));
    // });

    FirebaseFireStoreService.getOrders().then((value) {
      for (var doc in value.docs) {
        var data = doc.data();
        FirebaseFireStoreService.getOrdersDetails(userId: data['userID']);
        print("Orders ===== ---- ===== $data\n");
      }
      emit(OrdersSuccessState());
    }).catchError((onError) {
      print("Error ========== $onError");
      emit(OrdersErrorState(onError));
    });
  }
}
