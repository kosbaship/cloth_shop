abstract class ManageProductsScreenStates {}

class ManageProductsScreenInitialState extends ManageProductsScreenStates {}

class ManageProductsScreenLoadingState extends ManageProductsScreenStates {}

class ManageProductsScreenSuccessState extends ManageProductsScreenStates {}

class ManageProductsScreenErrorState extends ManageProductsScreenStates {
  final error;
  ManageProductsScreenErrorState(this.error);
}
