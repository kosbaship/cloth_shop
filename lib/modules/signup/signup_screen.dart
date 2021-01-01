import 'package:cloth_shop/modules/login/login_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double signUpScreenHeight = MediaQuery.of(context).size.height;

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
                  height: signUpScreenHeight * 0.1,
                ),
                buildTextField(
                  icon: Icons.person,
                  hint: 'Enter your name',
                  controller: nameController,
                  type: TextInputType.text,
                ),
                SizedBox(
                  height: signUpScreenHeight * 0.02,
                ),
                buildTextField(
                  icon: Icons.email,
                  hint: 'Enter your email',
                  controller: emailController,
                  type: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: signUpScreenHeight * 0.02,
                ),
                buildTextField(
                  icon: Icons.lock,
                  hint: 'Enter your password',
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                SizedBox(
                  height: signUpScreenHeight * 0.05,
                ),
                buildBtn(
                  function: () {
                    String name = nameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (name.isEmpty || email.isEmpty || password.isEmpty) {
                      showToast(message: "please enter your data", error: true);
                    } else {
                      // perform Signing up...
                      showToast(message: "perform Signing up...", error: false);
                    }
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
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToReplaceMe(context, LoginScreen());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
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
  }
}
