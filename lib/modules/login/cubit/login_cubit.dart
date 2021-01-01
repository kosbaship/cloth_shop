import 'package:cloth_shop/modules/login/cubit/login_states.dart';
import 'package:cloth_shop/shared/network/remote/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  signIn({email, password}) {
    //change the state
    emit(LoginLoadingState());

    //post the date
    FirebaseAuthService.signIn(email: email, password: password).then((value) {
      emit(LoginSuccessState());

      print("===================================");
      print(value.user.email);
      print("===================================");
    }).catchError((e) {
      emit(LoginErrorState(e.toString()));
    });
  }
}
