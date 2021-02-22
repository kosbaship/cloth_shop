import 'package:cloth_shop/models/user.dart';
import 'package:cloth_shop/modules/login/login_screen.dart';
import 'package:cloth_shop/modules/signup/cubit/signup_cubit.dart';
import 'package:cloth_shop/modules/signup/cubit/signup_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double signUpScreenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            showAlertDialog(
              context: context,
              text: 'please wait ...',
            );
          }

          if (state is SignUpSuccessState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            navigateToReplaceMe(
              context,
              LoginScreen(
                email: emailController.text,
                password: passwordController.text,
              ),
            );
          }

          if (state is SignUpErrorState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            showAlertDialog(
              context: context,
              text: "This account is already exist",
              error: true,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kMainColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                      ),
                      showLogo(screenHeight: signUpScreenHeight),
                      SizedBox(
                        height: signUpScreenHeight * 0.04,
                      ),buildTextFormField(
                        title: 'Name',
                        controller: nameController,
                        icon: Icons.person,
                      ),
                      SizedBox(
                        height: signUpScreenHeight * 0.03,
                      ),
                      buildTextFormField(
                          title: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          icon: Icons.email),
                      SizedBox(
                        height: signUpScreenHeight * 0.03,
                      ),
                      buildTextFormField(
                        title: 'Phone',
                        controller: phoneController,
                        icon: Icons.phone_android,
                      ),
                      SizedBox(
                        height: signUpScreenHeight * 0.03,
                      ),
                      buildTextFormField(
                          title: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          icon: Icons.lock,
                          obscureText: true),
                      SizedBox(
                        height: signUpScreenHeight * 0.05,
                      ),
                      buildButton(
                        onPressed: () {
                          String name = nameController.text.trim();
                          String email = emailController.text.trim();
                          String phone = phoneController.text.trim();
                          String password = passwordController.text.trim();

                          _checkValidationAndSignUP(
                            context: context,
                            name: name,
                            email: email,
                            phone: phone,
                            password: password,
                          );
                        },
                        title: 'Sign up',
                      ),
                      SizedBox(
                        height: signUpScreenHeight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'I have an account ? ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: kGreyColor, fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateToReplaceMe(context, LoginScreen());
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 16, color: kSloganColor),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
void _checkValidationAndSignUP({
  @required BuildContext context,
  @required String name,
  @required String email,
  @required String phone,
  @required String password,
}) {
  // check if the field are empty
  if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
    showToast(message: 'please enter your data', error: true);
  } else {
    // check every fields validation
    if (name.length < 3) {
      showToast(message: 'name must be at least 3 Characters', error: true);
    } else if (!email.contains('@')) {
      showToast(message: 'please, enter a valid email', error: true);
    } else if (password.length > 6) {
      showToast(message: 'password must be at least 3 Characters', error: true);
    }
    // register the user
    SignUpCubit.get(context).signUp(
        user: User(
            userName: name,
            userEmail: email,
            userPhone: phone,
            userPassword: password
        )
    );
  }
}