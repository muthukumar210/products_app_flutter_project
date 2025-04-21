// lib/screens/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import 'edit_product_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final product = provider.getProductById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: product == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('\$${product.price}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 16),
                  Text(product.description, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the Edit Product screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProductScreen(productId: product.id),
                        ),
                      );
                    },
                    child: Text('Edit Product'),
                  ),
                ],
              ),
            ),
    );
  }
}
