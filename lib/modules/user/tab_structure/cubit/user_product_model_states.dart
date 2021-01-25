abstract class UserProductModelStates {}

class UserProductModelInitialState extends UserProductModelStates {}

class UserProductModelLoadingState extends UserProductModelStates {}

class UserProductModelSuccessState extends UserProductModelStates {}

class UserProductModelErrorState extends UserProductModelStates {
  final error;
  UserProductModelErrorState(this.error);
}
