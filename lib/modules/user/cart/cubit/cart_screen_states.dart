abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartSuccessState extends CartStates {}

class CartErrorState extends CartStates {
  final error;
  CartErrorState(this.error);
}
