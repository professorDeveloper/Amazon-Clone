
import 'package:flutter/widgets.dart';
import 'package:untitled1/constains/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/widgets.dart';
import '../../features/product_detailes/screens/product_detail_screens.dart';
import '../../model/product.dart';
import '../service/home_service.dart';
class CarouselImages extends StatefulWidget {
  const CarouselImages({Key? key}) : super(key: key);
  static const String routeName = '/carousel-image';

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  List<Product>? productList;
  late Product product;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: "News",

    );
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
    return productList == null
        ? const Loader()
        :GestureDetector(
          onTap:navigateToDetailScreen,
        child: Container(
      child:         SingleChildScrollView(
          child:CarouselSlider(
          items: productList!.map(
    (i) {
      return Builder(
          builder: (BuildContext context,) =>
              Image.network(
                i.images[0],
                fit:BoxFit.fill,
                height: 300,
              ),


      );
    },
    ).toList(),
    options: CarouselOptions(
    autoPlay: true,
    viewportFraction: 1,
    height: 250,
    autoPlayAnimationDuration: const Duration(milliseconds: 100),

    ),
    ),
      ),
    ),
        );

  }
}


// @override
// void initState() {
//   super.initState();
//   fetchCategoryProducts();
// }
//
// fetchCategoryProducts() async {
//   productList = await homeServices.fetchCategoryProducts(
//     context: context,
//     category: widget.category,
//   );
//   setState(() {});
// }
// CarouselSlider(
// items: productList!.map(
// (i) {
// return Builder(
// builder: (BuildContext context,) =>
// Image.network(
// i.images[0],
// fit:BoxFit.fill,
// height: 300,
// semanticLabel: i.name,),
//
//
// );
// },
// ).toList(),
// options: CarouselOptions(
// autoPlay: true,
// viewportFraction: 1,
// height: 250,
// autoPlayAnimationDuration: const Duration(milliseconds: 100),
//
// ),
// )
