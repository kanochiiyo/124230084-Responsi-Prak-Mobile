import 'package:flutter/material.dart';
import 'package:responsi/controllers/product_controller.dart';
import 'package:responsi/views/detail_view.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final ProductController productController = ProductController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  Future<void> fetchProductData() async {
    try {
      await productController.fetchProductData();
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mendapatkan data produk: $e")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyToko Gue",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // Grid produk
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            final product =
                                productController.productList[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailView(product: product),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: _productCard(context, index),
                        ),
                      ),
                      childCount: productController.productList.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _productCard(context, index) {
    final product = productController.productList[index];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(81, 0, 0, 0),
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.imageUrl,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // TEKS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),

                Text(
                  "Price: ${product.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
