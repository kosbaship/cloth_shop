import 'package:cloth_shop/modules/user/product_details_screen/cubit/product_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreenCubit extends Cubit<ProductDetailsScreenStates>
{
  ProductDetailsScreenCubit() : super(ProductDetailsScreenStateInitial());

  static ProductDetailsScreenCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  plus(){
    counter ++;
    emit(ProductDetailsScreenStatePlus());
  }

  minus(){
    counter --;
  emit(ProductDetailsScreenStateMinus());
}

  String currentMode = 'notmytype';
  String favoriteMode = 'myfavorite';
  String unFavoriteMode = 'notmytype';

  addToFavorite() {
    currentMode = favoriteMode;
    emit(ProductDetailsScreenStateFavorite());
  }

  removeFromMyFavorite() {
    currentMode = unFavoriteMode;
    emit(ProductDetailsScreenStateUnFavorite());
  }
}
