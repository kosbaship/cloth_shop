abstract class BagsStates {}

class BagsInitialState extends BagsStates {}

class BagsLoadingState extends BagsStates {}

class BagsSuccessState extends BagsStates {}

class BagsErrorState extends BagsStates {
  final error;
  BagsErrorState(this.error);
}
