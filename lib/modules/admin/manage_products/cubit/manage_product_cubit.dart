import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/manage_products/cubit/manage_products_states.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProductCubit extends Cubit<ManageProductStates> {
  ManageProductCubit() : super(ManageProductInitialState());

  static ManageProductCubit get(context) => BlocProvider.of(context);
  List<ProductModel> products = [];

  loadProduct() {
    emit(ManageProductLoadingState());

    FirebaseFireStoreService.getProducts().then((value) {
      emit(ManageProductSuccessState());

      for (var doc in value.docs) {
        var data = doc.data();
        products.add(ProductModel(
            pId: doc.id,
            pPrice: data[kProductPrice],
            pName: data[kProductName],
            pDescription: data[kProductDescription],
            pLocation: data[kProductLocation],
            pCategory: data[kProductCategory]));
      }

      print("Hopa ========== ${products.length}");
      print("Hopa ========== ${value.docs[7].data()}");
    }).catchError((onError) {
      print("Error ========== $onError");
      emit(ManageProductErrorState(onError));
    });
  }
}
