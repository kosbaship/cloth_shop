import 'package:cloth_shop/modules/login/login_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customMaterialColor,
      ),
      home: LoginScreen(),
    );
  }
}
