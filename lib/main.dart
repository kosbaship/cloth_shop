import 'package:cloth_shop/modules/admin/home/cubit/admin_home_cubit.dart';
import 'package:cloth_shop/modules/login/login_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initApp();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdminHomeCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cloths Shop',
        theme: ThemeData(
            primarySwatch: customMaterialColor,
            primaryTextTheme:
                TextTheme(headline6: TextStyle(color: kWhiteColor))),
        home: LoginScreen(),
      ),
    );
  }
}
