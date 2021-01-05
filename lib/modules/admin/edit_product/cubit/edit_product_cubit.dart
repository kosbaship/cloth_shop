import 'package:cloth_shop/modules/admin/edit_product/cubit/edit_product_states.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductCubit extends Cubit<EditProductStates> {
  EditProductCubit() : super(EditProductInitialState());

  static EditProductCubit get(context) => BlocProvider.of(context);

  updateProduct({product, docId}) {
    emit(EditProductLoadingState());

    FirebaseFireStoreService.editProduct(
            productData: product, documentId: docId)
        .then((value) {
      emit(EditProductSuccessState());
    }).catchError((e) {
      emit(EditProductErrorState(e.toString()));
    });
  }

  deleteProduct({docId}) {
    emit(EditProductLoadingState());

    FirebaseFireStoreService.deleteProduct(documentId: docId).then((value) {
      emit(EditProductSuccessState());
    }).catchError((e) {
      emit(EditProductErrorState(e.toString()));
    });
  }
}
