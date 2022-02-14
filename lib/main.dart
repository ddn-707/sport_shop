import 'package:flutter/material.dart';
import 'package:myapp/providers/orders.dart';
import 'package:provider/provider.dart';

import 'package:myapp/screens/product_details.dart';
import 'package:myapp/screens/product_overview.dart';
import 'package:myapp/screens/cart_screen.dart';
import 'package:myapp/screens/order_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
        value: Products(),),
        ChangeNotifierProvider.value(
          value: Cart()
        ),
        ChangeNotifierProvider.value(
          value: Orders()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
        },
      ),
    );
  }
}

