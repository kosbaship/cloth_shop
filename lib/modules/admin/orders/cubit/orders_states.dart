abstract class OrdersStates {}

class OrdersInitialState extends OrdersStates {}

class OrdersLoadingState extends OrdersStates {}

class OrdersSuccessState extends OrdersStates {}

class OrdersErrorState extends OrdersStates {
  final error;
  OrdersErrorState(this.error);
}
