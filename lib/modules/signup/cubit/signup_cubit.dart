import 'package:cloth_shop/modules/signup/cubit/signup_states.dart';
import 'package:cloth_shop/shared/network/remote/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  signUp({email, password}) {
    //change the state
    emit(SignUpLoadingState());

    //post the date
    FirebaseAuthService.signUp(email: email, password: password).then((value) {
      emit(SignUpSuccessState());

      print("===================================");
      print(value.user.email);
      print("===================================");
    }).catchError((e) {
      emit(SignUpErrorState(e.toString()));
    });
  }
}
