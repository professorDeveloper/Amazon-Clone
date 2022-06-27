import 'package:untitled1/common/widgets/bottom_bar.dart';
import 'package:untitled1/features/account/wdigets/orders.dart';
import 'package:untitled1/features/address/screen/addres_screen.dart';
import 'package:untitled1/features/admin/screens/add_product_screen.dart';
import 'package:untitled1/features/auth/screems/auth_screens.dart';
import 'package:untitled1/features/order_detail/screens/order_detail_screen.dart';
import 'package:untitled1/features/product_detailes/screens/product_detail_screens.dart';
import 'package:untitled1/home/screen/catergory_deal_screen.dart';
import 'package:untitled1/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/model/order.dart';
import 'package:untitled1/model/product.dart';

import 'features/search/screen/search_screen.dart';
import 'home/wdigets/carousel_image.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CarouselImages.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CarouselImages(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(product: product,),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(order: order,),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Screen does not exts !"),
            ),
          ));


  }

}
