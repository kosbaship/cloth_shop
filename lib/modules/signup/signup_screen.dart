import 'package:cloth_shop/models/user.dart';
import 'package:cloth_shop/modules/login/login_screen.dart';
import 'package:cloth_shop/modules/signup/cubit/signup_cubit.dart';
import 'package:cloth_shop/modules/signup/cubit/signup_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:cloth_shop/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                        ),
                        showLogo(screenHeight: signUpScreenHeight),
                        SizedBox(
                          height: signUpScreenHeight * 0.04,
                        ),
                        buildTextFormField(
                          title: kTextFormName,
                          controller: nameController,
                          icon: Icons.person,
                        ),
                        SizedBox(
                          height: signUpScreenHeight * 0.03,
                        ),
                        buildTextFormField(
                            title: kTextFormEmail,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            icon: Icons.email),
                        SizedBox(
                          height: signUpScreenHeight * 0.03,
                        ),
                        buildTextFormField(
                          title: kTextFormPhone,
                          controller: phoneController,
                          icon: Icons.phone_android,
                        ),
                        SizedBox(
                          height: signUpScreenHeight * 0.03,
                        ),
                        buildTextFormField(
                            title: kTextFormPassword,
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

                            if (_formKey.currentState.validate()) {
                              _checkValidationAndSignUP(
                                context: context,
                                name: name,
                                email: email,
                                phone: phone,
                                password: password,
                              );
                            }
                          },
                          title: kSignUp,
                        ),
                        SizedBox(
                          height: signUpScreenHeight * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                kHaveNoAccount,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: kGreyColor, fontSize: 16),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateToReplaceMe(context, LoginScreen());
                              },
                              child: Text(
                                kSignIn,
                                style:
                                    TextStyle(fontSize: 16, color: kSloganColor),
                              ),
                            )
                          ],
                        ),


                    SizedBox(
                    height: signUpScreenHeight * 0.05,
                ),
                      ],
                    ),
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
  SignUpCubit.get(context).signUp(
      user: User(
          userName: name,
          userEmail: email,
          userPhone: phone,
          userPassword: password));
}
