abstract class ManageProductStates {}

class ManageProductInitialState extends ManageProductStates {}

class ManageProductLoadingState extends ManageProductStates {}

class ManageProductSuccessState extends ManageProductStates {}

class ManageProductErrorState extends ManageProductStates {
  final error;
  ManageProductErrorState(this.error);
}
