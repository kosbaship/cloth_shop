import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/user/tab_structure/cubit/states.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagsCubit extends Cubit<BagsStates> {
  BagsCubit() : super(BagsInitialState());

  static BagsCubit get(context) => BlocProvider.of(context);
  List<ProductModel> products = [];

  loadProduct() {
    emit(BagsLoadingState());

    FirebaseFireStoreService.getProducts().then((value) {
      emit(BagsSuccessState());

      for (var doc in value.docs) {
        var data = doc.data();
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
      emit(BagsErrorState(onError));
    });
  }
}
