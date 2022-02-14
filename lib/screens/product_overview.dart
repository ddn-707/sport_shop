import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myapp/widgets/products_grid.dart';
import 'package:myapp/providers/cart.dart';
import 'package:myapp/screens/cart_screen.dart';
import 'package:myapp/widgets/app_drawer.dart';
import 'package:myapp/widgets/badge.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (FilterOptions.Favorites == selectedValue) {
                    _showOnlyFavorites = true;
                    // productContainer.showFavoriteOnly();
                  } else {
                    // productContainer.showAll();
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('only Favorites'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show all'),
                      value: FilterOptions.All,
                    )
                  ]),
          Consumer<Cart>(builder: (_, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
          ),
              child: IconButton(
                  onPressed: () => {
                    Navigator.of(context).pushNamed(CartScreen.routeName),
                  },
                  icon: Icon(
                    Icons.shopping_cart,
              )),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}
