abstract class EditProductStates {}

class EditProductInitialState extends EditProductStates {}

class EditProductLoadingState extends EditProductStates {}

class EditProductSuccessState extends EditProductStates {}

class EditProductErrorState extends EditProductStates {
  final error;
  EditProductErrorState(this.error);
}
