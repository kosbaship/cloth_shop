import 'package:cloth_shop/models/order.dart';
import 'package:cloth_shop/modules/admin/orders/cubit/orders_cubit.dart';
import 'package:cloth_shop/modules/admin/orders/cubit/orders_states.dart';
import 'package:cloth_shop/shared/colors/colors.dart';
import 'package:cloth_shop/shared/components/compnents.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<OrderModel> orders = OrdersCubit.get(context).orders;
        return ConditionalBuilder(
          condition: state is! OrdersLoadingState,
          builder: (context) => ConditionalBuilder(
            condition: orders.length == 0,
            builder: (context) => Scaffold(
              backgroundColor: kMainColor,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding:
                  const EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          writeQuickText(
                            text: "Orders ",
                            textAlign: TextAlign.start,
                            fontSize: 28,
                          ),
                          writeQuickText(
                              text: '\(${orders.length}\)',
                              fontSize: 22,
                              color: kMainColor),
                        ],
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            buildExpandedCourseItem(
                                startToday: () {
                                  showToast(
                                      message:
                                      "yes Course price is 50\$",
                                      error: false);
                                },
                                startDate:
                                 '2021-01-01',
                                price:
                                16.99.toString(),
                                image:
                                NetworkImage(
                                        "http://via.placeholder.com/350x150"),
                                title:"Wordpress",
                                description: "Create your own website from scratch ",
                                initiallyExpanded: false),
                       //itemCount: orders.length,
                        itemCount: 5,
                        separatorBuilder:
                            (BuildContext context, int index) => SizedBox(
                          height: 15.0,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: Text(
              'Your have no Orders'.toUpperCase(),
              style: TextStyle(
                color: kMainColor,
                fontSize: 18,
              ),
            ),),

          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
