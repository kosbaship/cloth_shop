import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/user/tab_structure/cubit/user_product_model_states.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProductModelCubit extends Cubit<UserProductModelStates> {
  UserProductModelCubit() : super(UserProductModelInitialState());

  static UserProductModelCubit get(context) => BlocProvider.of(context);
  List<ProductModel> products = [];
  List<ProductModel> oneCategoryProductsUser = [];
  loadOneCategoryProductForUser({String searchCategory}) {
    oneCategoryProductsUser.clear();
    for (var product in products) {
        if(product.pCategory == searchCategory)
          oneCategoryProductsUser.add(product);
      }
  }
  loadAllProductForUser() {
    emit(UserProductModelLoadingState());

    FirebaseFireStoreService.getProducts().then((value) {

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
      loadOneCategoryProductForUser(searchCategory: kBags);
      emit(UserProductModelSuccessState());


    }).catchError((onError) {
      print("Error ========== $onError");
      emit(UserProductModelErrorState(onError));
    });
  }
}
