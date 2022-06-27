import 'package:untitled1/common/widgets/widgets.dart';
import 'package:untitled1/constains/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/features/account/service/account_service.dart';
import 'package:untitled1/features/account/wdigets/single_product.dart';
import 'package:untitled1/features/order_detail/screens/order_detail_screen.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List orders = [];
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty == true) {
      return const Loader();
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 1),
                child: const Text(
                  'Sotib Olgan Mahsulotingiz',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                ),
              ),
            ],
          ),
          // display orders
          Container(
            height: 170,
            padding: const EdgeInsets.only(
              left: 1,
              top: 40,
              right: 1,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailScreen.routeName,
                      arguments: orders[index],
                    );
                  },
                  child: SingleProduct(
                    image: orders[index].products[0].images[0],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
