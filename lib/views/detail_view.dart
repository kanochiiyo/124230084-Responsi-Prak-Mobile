import 'package:flutter/material.dart';
import 'package:responsi/models/product_model.dart';

class DetailView extends StatefulWidget {
    final ProductModel product;
  const DetailView({super.key, required this.product});
  

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}