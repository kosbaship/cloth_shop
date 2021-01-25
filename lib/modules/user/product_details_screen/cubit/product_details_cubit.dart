import 'package:cloth_shop/modules/user/product_details_screen/cubit/product_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterAndFavoriteCubit extends Cubit<CounterAndFavoriteStates>
{
  CounterAndFavoriteCubit() : super(CounterAndFavoriteStateInitial());

  static CounterAndFavoriteCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  plus(){
    counter ++;
    emit(CounterAndFavoriteStatePlus());
  }

  minus(){
    counter --;
  emit(CounterAndFavoriteStateMinus());
}

  String currentMode = 'notmytype';
  String favoriteMode = 'myfavorite';
  String unFavoriteMode = 'notmytype';

  addToFavorite() {
    currentMode = favoriteMode;
    emit(CounterAndFavoriteStateFavorite());
  }

  removeFromMyFavorite() {
    currentMode = unFavoriteMode;
    emit(CounterAndFavoriteStateUnFavorite());
  }
}
