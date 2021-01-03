import 'package:cloth_shop/modules/admin/home/admin_home_screen.dart';
import 'package:cloth_shop/modules/admin/home/cubit/admin_home_cubit.dart';
import 'package:cloth_shop/modules/login/cubit/login_cubit.dart';
import 'package:cloth_shop/modules/login/cubit/login_states.dart';
import 'package:cloth_shop/modules/signup/signup_screen.dart';
import 'package:cloth_shop/modules/user/home_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final String email;
  final String password;

  LoginScreen({this.email, this.password});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double loginScreenHeight = MediaQuery.of(context).size.height;
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
    }

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            buildProgressDialog(
              context: context,
              text: 'please wait ...',
            );
          }

          if (state is LoginSuccessState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            if (state.mode == LoginCubit.get(context).userMode) {
              navigateAndFinish(
                context,
                HomeScreen(),
              );
            } else if (state.mode == LoginCubit.get(context).adminMode) {
              AdminHomeCubit.get(context).currentIndex = 1;
              navigateAndFinish(
                context,
                AdminHomeScreen(),
              );
            }
          }

          if (state is LoginErrorState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            buildProgressDialog(
              context: context,
              text: "This account not found",
              error: true,
            );
          }
        },
        builder: (context, state) {
          String defaultMode = LoginCubit.get(context).currentMode;
          String adminMode = LoginCubit.get(context).adminMode;
          String userMode = LoginCubit.get(context).userMode;
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
                      showLogo(screenHeight: loginScreenHeight),
                      SizedBox(
                        height: loginScreenHeight * 0.1,
                      ),
                      buildTextField(
                        icon: Icons.email,
                        hint: 'Enter your email',
                        controller: emailController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: loginScreenHeight * 0.02,
                      ),
                      buildTextField(
                        icon: Icons.lock,
                        hint: 'Enter your password',
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: loginScreenHeight * 0.05,
                      ),
                      buildBtn(
                        function: () {
                          String email = emailController.text;
                          String password = passwordController.text;

                          if (email.isEmpty || password.isEmpty) {
                            showToast(
                                message: "please enter your data", error: true);
                          } else {
                            _checkAdminOrUserAndLogin(
                              context: context,
                              email: email,
                              password: password,
                              defaultMode: defaultMode,
                              adminMode: adminMode,
                              userMode: userMode,
                            );
                          }
                        },
                        title: 'Login',
                      ),
                      SizedBox(
                        height: loginScreenHeight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Don\'t have an account ? ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateToReplaceMe(context, SignUpScreen());
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: loginScreenHeight * 0.05,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                LoginCubit.get(context).changeToAdminMode();
                                print('i\'m an admin my mode is $defaultMode');
                              },
                              child: Text(
                                'i\'m an admin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: defaultMode == adminMode
                                        ? Colors.deepOrange
                                        : kWhiteColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                LoginCubit.get(context).changeToUserMode();
                                print('i\'m a user my mode is $defaultMode');
                              },
                              child: Text(
                                'i\'m a user',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: defaultMode == userMode
                                        ? Colors.deepOrange
                                        : kWhiteColor),
                              ),
                            ),
                          ),
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

  _checkAdminOrUserAndLogin(
      {context, email, password, defaultMode, userMode, adminMode}) {
    const String adminPassword = 'kosba4';
    if (defaultMode == userMode) {
      LoginCubit.get(context)
          .signIn(email: email, password: password, mode: userMode);
      print("login as user");
    } else if (defaultMode == adminMode) {
      if (password == adminPassword) {
        LoginCubit.get(context)
            .signIn(email: email, password: password, mode: adminMode);
        print("login as admin");
      } else {
        buildProgressDialog(
            context: context, text: 'Wrong Credentials', error: true);
      }
    }
  }
}
