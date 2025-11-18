import 'package:flutter/material.dart';
import 'package:responsi/models/product_model.dart';
import 'package:responsi/services/product_service.dart';
import 'package:responsi/services/cart_service.dart';

class ProductController {
  final ProductService productService = ProductService();
  final CartService cartService = CartService();

  List<ProductModel> productList = [];

  Future<void> fetchProductData() async {
    try {
      productList = await productService.fetchProductData();
    } catch (e) {
      debugPrint("Error fetch produk: $e");
    }
  }

  Future<List<ProductModel>> fetchCartProduct() async {
    try {
      final List<String> ids = await cartService.getCartIds();

      if (ids.isEmpty) {
        return [];
      }

      // Biar berjalan sama-sama dengan request API
      final futures = ids.map((id) => productService.getProductById(id));
      return await Future.wait(futures);
    } catch (e) {
      throw Exception("Gagal memuat daftar cart produk : $e");
    }
  }
}
