abstract class ProductDetailsScreenStates {}

class ProductDetailsScreenStateInitial extends ProductDetailsScreenStates {}

class ProductDetailsScreenStatePlus extends ProductDetailsScreenStates {}

class ProductDetailsScreenStateMinus extends ProductDetailsScreenStates {}



class ProductDetailsScreenStateUnFavorite extends ProductDetailsScreenStates {}
class ProductDetailsScreenStateFavorite extends ProductDetailsScreenStates {}



class ProductDetailsScreenLoadingState extends ProductDetailsScreenStates {}

class ProductDetailsScreenSuccessState extends ProductDetailsScreenStates {}

class ProductDetailsScreenErrorState extends ProductDetailsScreenStates {
  final error;
  ProductDetailsScreenErrorState(this.error);
}
