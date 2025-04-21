// lib/screens/edit_product_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;

  EditProductScreen({required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final product = Provider.of<ProductProvider>(context, listen: false).getProductById(widget.productId);
    _nameController = TextEditingController(text: product?.name ?? '');
    _priceController = TextEditingController(text: product?.price.toString() ?? '');
    _descriptionController = TextEditingController(text: product?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProduct = Product(
        id: widget.productId,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
      );

      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(widget.productId, updatedProduct);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context).getProductById(widget.productId);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: product == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Product Name'),
                      validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(labelText: 'Product Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Please enter a price' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Product Description'),
                      maxLines: 3,
                      validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _saveProduct,
                      child: Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
