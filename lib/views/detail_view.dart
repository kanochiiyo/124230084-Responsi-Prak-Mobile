import 'package:flutter/material.dart';
import 'package:responsi/models/product_model.dart';
import 'package:responsi/services/cart_service.dart';

class DetailView extends StatefulWidget {
  final ProductModel product;
  const DetailView({super.key, required this.product});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final CartService cartService = CartService();

  bool isLoading = true;
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final productId = widget.product.id.toString();
    final isFav = await cartService.isAdded(productId);
    if (mounted) {
      setState(() {
        isAdded = isFav;
        isLoading = false;
      });
    }
  }

  Future<void> addToCart() async {
    final productId = widget.product.id.toString();

    setState(() {
      isAdded = !isAdded;
    });

    try {
      await cartService.addToCart(productId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isAdded ? "Ditambahkan ke keranjang." : "Dihapus dari keranjang",
            ),
            backgroundColor: isAdded ? Colors.green : Colors.grey,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isAdded = !isAdded;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal memperbarui keranjang: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.cover,
                      height: 400,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "\$${widget.product.price}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Chip(
                              label: Text(
                                widget.product.category.isNotEmpty
                                    ? widget.product.category
                                    : '-',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: addToCart,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAdded
                                  ? Colors.red
                                  : Colors.blueAccent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isAdded
                                      ? Icons.remove_shopping_cart_rounded
                                      : Icons.add_shopping_cart_rounded,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 10,
                                  ),
                                  child: isAdded
                                      ? Text(
                                          "Remove from cart",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Text(
                                          "Add to cart",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          widget.product.description.isNotEmpty
                              ? widget.product.description
                              : "No description available.",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
