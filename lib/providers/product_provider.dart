// providers/product_provider.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final fetched = await ProductService.fetchProducts();
      _products = fetched ?? []; // just in case it's null
    } catch (e) {
      print('Error fetching products: $e');
      _products = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await ProductService.addProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(String id, Product product) async {
    await ProductService.updateProduct(id, product);
    await fetchProducts();
  }

  Future<void> deleteProduct(String id) async {
    await ProductService.deleteProduct(id);
    await fetchProducts();
  }

  Product? getProductById(String id) {
    return _products.firstWhere((prod) => prod.id == id, orElse: () => Product(id: '', name: 'Unknown', price: 0.0, description: 'No description available'));
  }
}
