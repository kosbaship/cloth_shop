import 'package:cloth_shop/models/product.dart';
import 'package:cloth_shop/modules/admin/add_products/cubit/add_product_states.dart';
import 'package:cloth_shop/shared/network/remote/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  static AddProductCubit get(context) => BlocProvider.of(context);

  saveProduct({ProductModel product}) {
    //change the state
    emit(AddProductLoadingState());

    //post the date
    FirebaseFireStoreService.createCollectionAndAddProduct(product: product)
        .then((value) {
      emit(AddProductSuccessState());
    }).catchError((e) {
      emit(AddProductErrorState(e.toString()));
    });
  }
}
