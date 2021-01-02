abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String mode;
  LoginSuccessState(this.mode);
}

class LoginErrorState extends LoginStates {
  final error;
  LoginErrorState(this.error);
}

class LoginUserState extends LoginStates {}

class LoginAdminState extends LoginStates {}
