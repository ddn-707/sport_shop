import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myapp/providers/orders.dart' show Orders;
import 'package:myapp/widgets/order_item.dart';
import 'package:myapp/widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occurred'),
                );
              } else {
                return Consumer<Orders>(builder: (ctx, orderData,child) =>ListView.builder(
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                  itemCount: orderData.orders.length,
                )); 
              }
            }
          },
        ));
  }
}
