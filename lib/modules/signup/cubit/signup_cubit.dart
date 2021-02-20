import 'package:cloth_shop/models/user.dart';
import 'package:cloth_shop/modules/signup/cubit/signup_states.dart';
import 'package:cloth_shop/network/cloud_firestore.dart';
import 'package:cloth_shop/network/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  signUp({@required User user}) {
    //change the state
    emit(SignUpLoadingState());

    //post the date
    FirebaseAuthService.signUp(email: user.userEmail, password: user.userPassword)
        .then((userCredential) {
      emit(SignUpSuccessState());

      FirebaseFireStoreService.storeUsers(
          user: User(
              userID: userCredential.user.uid,
              userName: user.userName,
              userEmail: user.userEmail,
              userPhone: user.userPhone,
              userPassword: user.userPassword)
      );

      print("\n===================================");
      print('= = = = = = = > ${userCredential.user.uid}');
      print('= = = = = = = > ${userCredential.user.email}');
      print('= = = = = = = > User Stored Successfully');
      print("===================================\n\n");
    }).catchError((e) {
      emit(SignUpErrorState(e.toString()));
    });
  }
}
