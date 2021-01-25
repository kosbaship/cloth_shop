import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/products/manage_products/cubit/manage_products_screen_states.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProductsScreensCubit extends Cubit<ManageProductsScreenStates> {
  ManageProductsScreensCubit() : super(ManageProductsScreenInitialState());

  static ManageProductsScreensCubit get(context) => BlocProvider.of(context);
  List<ProductModel> products = [];

  loadProductForAdmin({String searchCategory}) {
    emit(ManageProductsScreenLoadingState());

    FirebaseFireStoreService.getProducts().then((value) {
      emit(ManageProductsScreenSuccessState());

      for (var doc in value.docs) {
        var data = doc.data();
        if(data[kProductCategory] == searchCategory)
        products.add(ProductModel(
            pId: doc.id,
            pPrice: data[kProductPrice],
            pName: data[kProductName],
            pColor: data[kProductColor],
            pImageUrl: data[kProductImageUrl],
            pDescription: data[kProductDescription],
            pCategory: data[kProductCategory]));
      }
    }).catchError((onError) {
      print("Error ========== $onError");
      emit(ManageProductsScreenErrorState(onError));
    });
  }
}
