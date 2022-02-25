import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myapp/providers/orders.dart';
import 'package:myapp/screens/edit_product_screen.dart';
import 'package:myapp/screens/user_product_screen.dart';
import 'package:myapp/screens/product_details.dart';
import 'package:myapp/screens/product_overview.dart';
import 'package:myapp/screens/cart_screen.dart';
import 'package:myapp/screens/order_screen.dart';
import 'package:myapp/providers/auth.dart';
import 'package:myapp/screens/auth_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final authData = Provider.of<Auth>(context, listen: false);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(create: (_) {
            return Products('', '', []);
          }, update: (ctx, auth, previousProducts) {
            return Products(auth.token, auth.userId,
                previousProducts == null ? [] : previousProducts.items);
          }),
          // ChangeNotifierProvider.value(value: Products()),
          ChangeNotifierProvider.value(value: Cart()),
          // ChangeNotifierProvider.value(value: Orders()),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: (context) => Orders('', '', []),
              update: (ctx, auth, previousOrders) => Orders(
                  auth.token,
                  auth.userId,
                  previousOrders == null ? [] : previousOrders.orders))
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrderScreen.routeName: (context) => OrderScreen(),
              UserProductScreen.routeName: (context) => UserProductScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
              AuthScreen.routeName: (context) => AuthScreen(),
            },
          ),
        ));
  }
}
