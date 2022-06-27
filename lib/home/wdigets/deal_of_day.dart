import 'package:flutter/material.dart';

import '../../common/widgets/widgets.dart';
import '../../features/product_detailes/screens/product_detail_screens.dart';
import '../../model/product.dart';
import '../service/home_service.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
        ? const SizedBox()
        : GestureDetector(
      onTap: navigateToDetailScreen,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: const Text(
              'Kunlik Yangi Mahsulotlar',
              style: TextStyle(fontSize: 17),
            ),
          ),
          Image.network(
            product!.images[0],
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.topLeft,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding:
            const EdgeInsets.only(left: 15, top: 5, right: 40),
            child: const Text(
              'Barchasi',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: product!.images
                  .map(
                    (e) => Image.network(
                  e,
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              )
                  .toList(),
            ),
          ),

        ],
      ),
    );
  }
}