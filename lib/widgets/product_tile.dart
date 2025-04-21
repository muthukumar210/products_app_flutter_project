// lib/widgets/product_tile.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    print('Rendering product: ${product.name}');

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(product.name),
        subtitle: Text('\$${product.price}'),
        onTap: () {
          // Navigate to product details screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(productId: product.id),
            ),
          );
        },
      ),
    );
  }
}
