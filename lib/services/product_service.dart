import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi/models/product_model.dart';

class ProductService {
  final String baseUrl = "https://fakestoreapi.com";

  Future<List<ProductModel>> fetchProductData() async {
    final String fullUrl = "$baseUrl/products";
    final response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List product = data;
      return product.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal fetch API.");
    }
  }

  Future<ProductModel> getProductById(String id) async {
    final String fullUrl = "$baseUrl/products/$id";
    final response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final Map<String, dynamic> data = json;
      return ProductModel.fromJson(data);
    } else {
      throw Exception("Gagal mengambil data produk dengan id $id");
    }
  }
}
