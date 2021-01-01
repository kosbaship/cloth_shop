import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double loginScreenHeight = MediaQuery.of(context).size.height;

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
                    showToast(message: "Login...", error: false);
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
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showToast(message: "Move to sign up", error: false);
                      },
                      child: Text(
                        'Signup',
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
