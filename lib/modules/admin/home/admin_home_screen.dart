import 'package:cloth_shop/modules/admin/home/cubit/admin_home_cubit.dart';
import 'package:cloth_shop/modules/login/login_screen.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/admin_home_states.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminHomeCubit, AdminHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // used more than once
        var currentIndex = AdminHomeCubit.get(context).currentIndex;

        return Scaffold(
          backgroundColor: kWhiteColor,
          appBar: drawAppbar(
            context: context,
            leadingWidget: Container(),
            title: AdminHomeCubit.get(context).titles[currentIndex],
            actionWidget: IconButton(
              icon: Icon(
                Icons.logout,
                size: 30.0,
                color: kWhiteColor,
              ),
              onPressed: () {
                AdminHomeCubit.get(context).signOut();
                navigateAndFinish(context, LoginScreen());
              },
            ),
          ),
          body: AdminHomeCubit.get(context).bodies[currentIndex],
          bottomNavigationBar: Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  25.0,
                ),
                topRight: Radius.circular(
                  25.0,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: kGreyColor.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
            ),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                  ),
                  label: 'Add Product',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.view_list_sharp,
                  ),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings_sharp,
                  ),
                  label: 'Manage Products',
                ),
              ],
              backgroundColor: Colors.transparent,
              onTap: (index) {
                AdminHomeCubit.get(context).changeIndex(index);
              },
              // current index match this index
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: kMainColor,
              elevation: 0.0,
            ),
          ),
        );
      },
    );
  }
}
