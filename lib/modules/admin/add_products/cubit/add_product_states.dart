abstract class AddProductStates {}

class AddProductInitialState extends AddProductStates {}

class AddProductLoadingState extends AddProductStates {}

class AddProductSuccessState extends AddProductStates {}

class AddProductErrorState extends AddProductStates {
  final error;
  AddProductErrorState(this.error);
}
