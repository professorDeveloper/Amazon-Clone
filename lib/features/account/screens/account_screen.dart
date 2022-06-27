import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/common/widgets/bottom_bar.dart';
import 'package:untitled1/constains/global_variables.dart';
import 'package:untitled1/features/account/wdigets/below_app_bar.dart';
import 'package:untitled1/features/account/wdigets/orders.dart';

import '../wdigets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/amazon.png',width: 120,height: 45,),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

      ),
      body: Column(
        children: const  [
          BelowAppBar(),
          SizedBox(height: 10,),
          TopButtons(),
          SizedBox(height: 10,),
          Orders(),
        ],
      ),
    );
  }
}
