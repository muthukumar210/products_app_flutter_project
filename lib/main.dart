// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_product_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Products App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/add': (context) => AddProductScreen(),
          '/product-details': (context) => const Placeholder(), // unused
          '/edit': (context) => const Placeholder(), // unused
        },
      ),
    );
  }
}
